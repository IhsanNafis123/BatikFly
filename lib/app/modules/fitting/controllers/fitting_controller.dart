import 'package:flutter/material.dart'; // TAMBAHKAN IMPORT INI
import 'package:get/get.dart';

class FittingController extends GetxController {
  var selectedIndex = 2.obs;

  // State untuk melacak pilihan
  var selectedMotifPath = 'assets/logo.jpeg'.obs; 
  var selectedModelType = 'Pendek'.obs; 

  final List<String> customMotifs = [
    'assets/logo.jpeg',
    'assets/logo.jpeg',
    'assets/logo.jpeg',
  ];

  void selectMotif(String path) => selectedMotifPath.value = path;
  void selectModel(String type) => selectedModelType.value = type;

  void processCreateModel() {
    Get.snackbar(
      "Sukses", 
      "Model 3D Lengan ${selectedModelType.value} berhasil diproses!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1A1B35), // Sekarang Color sudah dikenali
      colorText: const Color(0xFFEAC349),       // Sekarang Color sudah dikenali
    );
  }
}