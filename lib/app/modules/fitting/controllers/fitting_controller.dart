import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import '../../../config/api_config.dart';

class FittingController extends GetxController {
  // ================= STATE VARIABEL =================
  var isLoading = false.obs;
  var selectedIndex = 2.obs;

  var generatedVisualUrl = ''.obs;
  var generatedModel3DUrl = ''.obs;
  var uploadedMotifUrl = ''.obs;

  var selectedMotif = Rxn<File>();
  var selectedCustomMotifUrl = ''.obs;

  var selectedSize = 'L'.obs;
  var isLongSleeve = false.obs;

  var fabricResult = '1.5'.obs;
  var recommendedMaterial = 'Katun Primisima'.obs;
  var selectedModel = "assets/models/shirt_short.glb".obs;

  final supabase = Supabase.instance.client;
  var myDesigns = <Map<String, dynamic>>[].obs;

  // ================= FUNGSI KALKULASI =================
  void updateFabricRequirement() {
    double baseFabric = 1.5;
    if (selectedSize.value == 'XL' || selectedSize.value == 'XXL') {
      baseFabric += 0.25;
    }
    if (isLongSleeve.value) baseFabric += 0.5;

    fabricResult.value = baseFabric.toStringAsFixed(2);
    recommendedMaterial.value = isLongSleeve.value
        ? "Katun Dobby / Sutra"
        : "Katun Primisima / Paris";
  }

  // ================= FUNGSI PILIH MOTIF =================
  Future<void> pickMotifImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedMotif.value = File(pickedFile.path);
      selectedCustomMotifUrl.value = '';
      Get.snackbar(
        "Berhasil",
        "Motif dari galeri dipilih!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchMyDesigns() async {
    try {
      // AMBIL DARI SHARED PREFERENCES
      final box = GetStorage();
      final userId = box.read("user_id")?.toString();

      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "Anda harus login terlebih dahulu.");
        return;
      }

      print("DEBUG FLUTTER: Mencari desain untuk user_id: $userId");

      final data = await supabase
          .from('designs')
          .select('id, motif_name, image_url, user_id')
          .eq('user_id', userId) // Gunakan variabel userId baru
          .order('created_at', ascending: false);

      myDesigns.assignAll(List<Map<String, dynamic>>.from(data));
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat desain dari database.");
    }
  }

  void showSupabaseDesignPicker() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await fetchMyDesigns();
    Get.back();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF15192F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Dari Desain Anda",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (myDesigns.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada desain yang Anda buat.",
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: myDesigns.length,
                  itemBuilder: (context, index) {
                    final design = myDesigns[index];
                    return GestureDetector(
                      onTap: () {
                        selectedCustomMotifUrl.value = design['image_url'];
                        selectedMotif.value = null;
                        Get.back();
                        Get.snackbar(
                          "Desain Dipilih",
                          "Motif siap di-fitting!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(design['image_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            design['motif_name'] ?? 'Tanpa Nama',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _getReadyMotifUrl() async {
    if (selectedCustomMotifUrl.value.isNotEmpty)
      return selectedCustomMotifUrl.value;
    if (selectedMotif.value != null)
      return await _uploadMotifToBackend(selectedMotif.value!, 'motifs');
    return null;
  }

  Future<String?> _uploadMotifToBackend(File file, String folder) async {
    try {
      final String uploadUrl = ApiConfig.fittingUpload;
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(await http.MultipartFile.fromPath('image', file.path));
      request.fields['folder'] = folder;

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success'] == true) return data['motif_url'];
      }
      throw 'Gagal unggah.';
    } catch (e) {
      throw "Gagal Mengunggah Gambar";
    }
  }

  // ================= TOMBOL 1: TAMPILKAN 3D =================
  Future<void> processGeneration() async {
    // AMBIL DARI SHARED PREFERENCES
    final box = GetStorage();
    final userId = box.read("user_id")?.toString();

    if (userId == null || userId.isEmpty) {
      Get.snackbar("Error", "Anda harus login terlebih dahulu.");
      return;
    }

    isLoading.value = true;
    try {
      String? motifUrl = await _getReadyMotifUrl();
      if (motifUrl == null || motifUrl.isEmpty)
        throw "URL Motif kosong dari server";

      uploadedMotifUrl.value = motifUrl;

      final bodyData = {
        "user_id": userId,
        "motif_url": motifUrl,
        "size": selectedSize.value,
        "model": selectedModel.value,
      };

      final response = await http
          .post(
            Uri.parse(ApiConfig.fittingSave),
            headers: {"Content-Type": "application/json"},
            body: json.encode(bodyData),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        generatedVisualUrl.value = '';
        generatedModel3DUrl.value = responseData['data_render']['model_url'];
        Get.snackbar(
          "Selesai",
          "Model 3D berhasil dirender!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw "Gagal menyimpan. Kode: ${response.statusCode}";
      }
    } catch (e) {
      Get.snackbar(
        "Error Sistem",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================= TOMBOL 2: COBA DI FOTO SAYA (VTON) =================
  Future<void> tryOnFotoSendiri() async {
    final box = GetStorage();
    final userId = box.read("user_id")?.toString();

    if (userId == null || userId.isEmpty) {
      Get.snackbar("Error", "Anda harus login terlebih dahulu.");
      return;
    }

    final picker = ImagePicker();
    final pickedUserPhoto = await picker.pickImage(source: ImageSource.gallery);
    if (pickedUserPhoto == null) return;

    isLoading.value = true;
    try {
      String? motifUrl = await _getReadyMotifUrl();
      String? photoUrl = await _uploadMotifToBackend(
        File(pickedUserPhoto.path),
        'users',
      );

      if (motifUrl == null || photoUrl == null)
        throw "Gagal mengunggah gambar ke server.";

      final bodyData = {
        "user_id": userId,
        "user_photo_url": photoUrl,
        "batik_motif_url": motifUrl,
      };

      final response = await http
          .post(
            Uri.parse(ApiConfig.fittingVton),
            headers: {"Content-Type": "application/json"},
            body: json.encode(bodyData),
          )
          .timeout(const Duration(minutes: 2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        generatedModel3DUrl.value = '';
        generatedVisualUrl.value = data['result_url'];
        Get.snackbar(
          "Sukses",
          "Batik berhasil dipakai di foto Anda!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw "Error AI: ${response.body}";
      }
    } catch (e) {
      Get.snackbar(
        "Error AI",
        "Gagal memproses AI: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================= FUNGSI INJEKSI 3D (FIX TERBALIK VERTIKAL) =================
  void injectMotifKe3D(dynamic webViewController) {
    final url = uploadedMotifUrl.value;
    if (url.isEmpty) return;

    final jsCode =
        '''
      function applyBatik() {
          const viewer = document.querySelector('model-viewer');
          const changeTexture = async () => {
              try {
                  const img = new Image();
                  img.crossOrigin = 'Anonymous';
                  img.src = '$url';
                  
                  img.onload = async () => {
                      const canvas = document.createElement('canvas');
                      canvas.width = img.width;
                      canvas.height = img.height;
                      const ctx = canvas.getContext('2d');
                      
                      ctx.translate(0, canvas.height);
                      ctx.scale(1, -1);
                      
                      ctx.drawImage(img, 0, 0);
                      const fixedUrl = canvas.toDataURL('image/png');

                      const texture = await viewer.createTexture(fixedUrl);

                      viewer.model.materials.forEach((material)=>{
                          const pbr = material.pbrMetallicRoughness;
                          if(!pbr) return;
                          pbr.setBaseColorFactor([1,1,1,1]);
                          if(pbr.baseColorTexture){
                              pbr.baseColorTexture.setTexture(texture);
                          }
                      });
                  };
              } catch(e){
                  console.error(e);
              }
          };

          if (viewer && viewer.model) {
              changeTexture(); 
          } else if (viewer) {
              viewer.addEventListener('load', changeTexture); 
          } else {
              setTimeout(applyBatik, 500); 
          }
      }
      applyBatik();
    ''';

    Future.delayed(const Duration(milliseconds: 1500), () {
      try {
        webViewController.runJavaScript(jsCode);
      } catch (_) {}
    });
  }
}
