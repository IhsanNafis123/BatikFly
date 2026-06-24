import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class FittingController extends GetxController {
  // ================= STATE VARIABEL =================
  var isLoading = false.obs;
  var selectedIndex = 2.obs; 

  var generatedVisualUrl = ''.obs; // Hasil 2D Try-On
  var generatedModel3DUrl = ''.obs; // Hasil 3D Viewer
  
  var uploadedMotifUrl = ''.obs; // URL motif untuk disuntikkan ke 3D

  var selectedMotif = Rxn<File>();
  var selectedSize = 'L'.obs;
  var isLongSleeve = false.obs;

  var fabricResult = '1.5'.obs;
  var recommendedMaterial = 'Katun Primisima'.obs;

  // KONFIGURASI BACKEND
  final supabase = Supabase.instance.client;
  // GANTI IP INI SESUAI IP LAPTOP ANDA JIKA BERUBAH
  final String backendUrl = "http://192.168.56.105:5000/api/fitting"; 

  // ================= FUNGSI UTAMA =================

  void updateFabricRequirement() {
    double baseFabric = 1.5; 
    if (selectedSize.value == 'XL' || selectedSize.value == 'XXL') baseFabric += 0.25;
    if (isLongSleeve.value) baseFabric += 0.5;

    fabricResult.value = baseFabric.toStringAsFixed(2);
    recommendedMaterial.value = isLongSleeve.value ? "Katun Dobby / Sutra" : "Katun Primisima / Paris";
  }

  Future<void> pickMotifImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      selectedMotif.value = File(pickedFile.path);
      Get.snackbar("Berhasil", "Motif dipilih!", backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  // FUNGSI HELPER: UPLOAD KE SUPABASE STORAGE
  Future<String?> _uploadKeSupabase(File file, String folderPath) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '$folderPath/$fileName';
      
      // Upload ke bucket bernama 'storage' (Sesuai dengan kode Anda sebelumnya)
      await supabase.storage.from('storage').upload(path, file);
      
      // Dapatkan public URL
      return supabase.storage.from('storage').getPublicUrl(path);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  // TOMBOL 1: TAMPILKAN 3D & SIMPAN DATA FITTING
  Future<void> processGeneration() async {
    if (selectedMotif.value == null) {
      Get.snackbar("Peringatan", "Pilih motif batik terlebih dahulu!");
      return;
    }

    isLoading.value = true;
    try {
      // 1. Upload motif ke Supabase
      String? motifUrl = await _uploadKeSupabase(selectedMotif.value!, 'motifs');
      if (motifUrl == null) throw "Gagal upload motif";
      
      // Simpan URL untuk dipakai mewarnai model 3D
      uploadedMotifUrl.value = motifUrl; 

      // 2. Simpan Data ke Database via Flask
      final response = await http.post(
        Uri.parse('$backendUrl/save'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": supabase.auth.currentUser?.id ?? "anonymous",
          "motif_url": motifUrl,
          "size": selectedSize.value,
        }),
      );

      if (response.statusCode == 200) {
        generatedVisualUrl.value = ''; 
        generatedModel3DUrl.value = 'assets/scene.glb'; // Memunculkan 3D
        Get.snackbar("Disimpan", "Data ukuran & motif berhasil direkam di database!");
      } else {
        throw "Gagal menyimpan ke server.";
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memproses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // TOMBOL 2: COBA DI FOTO SAYA (VTON)
  Future<void> tryOnFotoSendiri() async {
    if (selectedMotif.value == null) {
      Get.snackbar("Peringatan", "Pilih motif batik terlebih dahulu!");
      return;
    }

    final picker = ImagePicker();
    final pickedUserPhoto = await picker.pickImage(source: ImageSource.gallery);
    if (pickedUserPhoto == null) return;

    isLoading.value = true;
    try {
      // 1. Upload Motif & Foto User
      String? motifUrl = await _uploadKeSupabase(selectedMotif.value!, 'motifs');
      String? photoUrl = await _uploadKeSupabase(File(pickedUserPhoto.path), 'users');

      if (motifUrl == null || photoUrl == null) throw "Gagal upload gambar ke Supabase";

      // 2. Panggil API AI (Fal.ai IDM-VTON) di Flask
      final response = await http.post(
        Uri.parse('$backendUrl/generate-vton'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_photo_url": photoUrl,
          "motif_url": motifUrl,
        }),
      );

      // 3. Tampilkan Hasil
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        generatedModel3DUrl.value = ''; 
        generatedVisualUrl.value = data['result_url']; // Menampilkan hasil AI
        Get.snackbar("Sukses", "Batik berhasil dipakai di foto Anda!", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        throw "Error AI Backend: ${response.body}";
      }
    } catch (e) {
      Get.snackbar("Error AI", "Gagal: $e", duration: const Duration(seconds: 4));
    } finally {
      isLoading.value = false;
    }
  }

  // ================= FUNGSI INJEKSI 3D =================
  // Memasukkan motif 2D ke dalam material objek 3D
  // ================= FUNGSI INJEKSI 3D =================
  void injectMotifKe3D(dynamic webViewController) {
    final url = uploadedMotifUrl.value;
    if (url.isEmpty) return;

    final jsCode = '''
      function applyBatik() {
          const viewer = document.querySelector('model-viewer');
          
          const changeTexture = async () => {
              try {
                  // Unduh gambar batik dari Supabase
                  const texture = await viewer.createTexture('$url');
                  
                  // Pastikan model 3D sudah siap
                  if(viewer.model && viewer.model.materials) {
                      // LOOPING: Paksa semua lapisan (kancing, kerah, kain) berubah jadi batik!
                      for (let i = 0; i < viewer.model.materials.length; i++) {
                          viewer.model.materials[i].pbrMetallicRoughness.baseColorTexture.setTexture(texture);
                      }
                  }
              } catch (e) {
                  console.error("Gagal muat tekstur:", e);
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

    // Beri jeda sedikit lebih lama agar 3D benar-benar ter-render di layar
    Future.delayed(const Duration(milliseconds: 1500), () {
      try {
        webViewController.runJavaScript(jsCode);
      } catch (e) {
        print("Gagal inject JS ke WebView: $e");
      }
    });
  }
  }
