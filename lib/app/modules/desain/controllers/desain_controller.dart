import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/desain_service.dart';

class DesainController extends GetxController {
  // ===========================
  // TEXT CONTROLLER
  // ===========================

  final TextEditingController promptController =
      TextEditingController();

  // ===========================
  // STATE
  // ===========================

  RxString selectedMode = "prompt".obs;

  RxString selectedMotif = "".obs;

  RxBool isLoading = false.obs;

  // ===========================
  // RESULT
  // ===========================

  RxString generatedImage = "".obs;

  RxString philosophy = "".obs;

  RxString density = "".obs;

  RxString motifName = "".obs;

  RxString modeResult = "".obs;

  // ===========================
  // DATA
  // ===========================

  RxList<String> motifList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMotifs();
  }

  // ===========================
  // LOAD MOTIF
  // ===========================

  Future<void> loadMotifs() async {
    try {
      final motifs = await DesignService.getMotifs();

      motifList.assignAll(motifs);

      if (motifs.isNotEmpty) {
        selectedMotif.value = motifs.first;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  // ===========================
  // GENERATE DESIGN
  // ===========================

  Future<void> generateMotif() async {
    if (promptController.text.trim().isEmpty) {
      Get.snackbar(
        "Warning",
        "Prompt tidak boleh kosong",
      );
      return;
    }

    try {
      isLoading.value = true;

      final result = await DesignService.generateDesign(
        mode: selectedMode.value,
        prompt: promptController.text.trim(),
        baseMotif: selectedMotif.value,
      );

      if (result["success"] == true) {
        final data = result["data"];

        generatedImage.value = data["image"] ?? "";

        philosophy.value = data["philosophy"] ?? "";

        density.value = data["density"] ?? "";

        modeResult.value = data["mode"] ?? selectedMode.value;

        motifName.value = data["motif"] ?? selectedMotif.value;

        Get.snackbar(
          "Success",
          "Motif berhasil dibuat",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          result["message"] ?? "Generate gagal",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ===========================
  // SAVE DESIGN
  // ===========================

  Future<void> saveDesign() async {
    try {
      final result = await DesignService.saveDesign(
        mode: modeResult.value,
        motifName: motifName.value,
        prompt: promptController.text.trim(),
        imageUrl: generatedImage.value,
        philosophy: philosophy.value,
        density: density.value,
      );

      if (result["success"] == true) {
        Get.snackbar(
          "Success",
          "Design berhasil disimpan",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          result["message"] ?? "Gagal menyimpan design",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  // ===========================
  // RESET
  // ===========================

  void resetForm() {
    promptController.clear();

    generatedImage.value = "";

    philosophy.value = "";

    density.value = "";

    motifName.value = "";

    modeResult.value = "";

    selectedMode.value = "prompt";

    if (motifList.isNotEmpty) {
      selectedMotif.value = motifList.first;
    }
  }

  @override
  void onClose() {
    promptController.dispose();
    super.onClose();
  }
}