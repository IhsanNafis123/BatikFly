import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/api_config.dart'; // Sesuaikan path menuju file api_config.dart Anda

class DesignArticle {
  final int id;
  final String motifName;
  final String imageUrl;
  final String philosophy;
  final String prompt;
  final String creatorName;
  final String? creatorAvatar;

  DesignArticle({
    required this.id,
    required this.motifName,
    required this.imageUrl,
    required this.philosophy,
    required this.prompt,
    required this.creatorName,
    this.creatorAvatar,
  });

  factory DesignArticle.fromJson(Map<String, dynamic> json) {
    final userData = json['users'];

    return DesignArticle(
      id: json['id'],
      motifName: json['motif_name'] ?? 'Motif Tanpa Nama',
      imageUrl: json['image_url'] ?? '',
      philosophy: json['philosophy'] ?? 'Belum ada filosofi',
      prompt: json['prompt'] ?? '',
      creatorName: userData != null ? userData['name'] ?? 'Anonim' : 'Anonim',
      creatorAvatar: userData != null ? userData['avatar'] : null,
    );
  }
}

class GalleryController extends GetxController {
  var selectedIndex = 3.obs;
  var articles = <DesignArticle>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDesigns();
  }

  Future<void> fetchDesigns() async {
    try {
      isLoading(true);

      final url = Uri.parse(ApiConfig.getGallery);

      // Request langsung TANPA token
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          final List<dynamic> dataList = responseData['data'];

          final List<DesignArticle> fetchedData = dataList
              .map((json) => DesignArticle.fromJson(json))
              .toList();

          articles.assignAll(fetchedData);
        } else {
          Get.snackbar("Info", responseData['message'] ?? "Data kosong");
        }
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat galeri. Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("ERROR FETCH GALLERY: $e");
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    } finally {
      isLoading(false);
    }
  }
}
