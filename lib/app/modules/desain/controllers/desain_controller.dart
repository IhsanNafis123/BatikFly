import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesainController extends GetxController {

  // TEXTFIELD CONTROLLER
  TextEditingController motifController =
      TextEditingController();

  // LOADING
  RxBool isLoading = false.obs;

  // GENERATED IMAGE
  RxString generatedImage =
      "assets/batik_ai.png".obs;

  // GENERATE MOTIF
  void generateMotif() async {

    if (motifController.text.isEmpty) {

      Get.snackbar(
        "Error",
        "Deskripsi motif wajib diisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    isLoading.value = true;

    await Future.delayed(
      const Duration(seconds: 2),
    );

    isLoading.value = false;

    Get.snackbar(
      "Success",
      "Motif berhasil dibuat",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // SAVE TO GALLERY
  void saveToGallery() {

    Get.snackbar(
      "Saved",
      "Motif disimpan ke galeri",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {

    motifController.dispose();

    super.onClose();
  }
}