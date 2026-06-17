import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/desain_service.dart';

class DesainController extends GetxController {

  // ================= TEXTFIELD =================

  TextEditingController promptController =
      TextEditingController();

  // ================= STATE =================

  var selectedMode =
      "prompt".obs;

  var selectedMotif =
      "Mega Mendung".obs;

  var isLoading = false.obs;

  var generatedImage =
      "".obs;

  var philosophy =
      "".obs;

  var density =
      "".obs;

  // ================= RESULT EXTRA =================

  var motifName =
      "".obs;

  var modeResult =
      "".obs;

  // ================= DATA =================

  var motifList =
      <String>[].obs;

  // ================= INIT =================

  @override
  void onInit() {

    loadMotifs();

    super.onInit();
  }

  Future<void> loadMotifs() async {

    try {

      final motifs =
          await DesignService
              .getMotifs();

      motifList.value =
          motifs;

      if (motifs.isNotEmpty) {

        selectedMotif.value =
            motifs.first;
      }

      print(
        "Motif Loaded : $motifList",
      );

    } catch (e) {

      print(
        "Load Motif Error : $e",
      );
    }
  }

  // ================= GENERATE =================

  Future<void> generateMotif()
      async {

    try {

      if (promptController
          .text
          .trim()
          .isEmpty) {

        Get.snackbar(

          "Warning",

          "Prompt tidak boleh kosong",

          backgroundColor:
              Colors.orange,

          colorText:
              Colors.white,
        );

        return;
      }

      isLoading.value = true;

      final result =
          await DesignService
              .generateDesign(

        mode:
            selectedMode.value,

        prompt:
            promptController.text,

        baseMotif:
            selectedMotif.value,
      );

      print(
        "RESULT => $result",
      );

      if (result["success"]) {

        generatedImage.value =
            result["data"]["image"] ?? "";

        philosophy.value =
            result["data"]["philosophy"] ?? "";

        density.value =
            result["data"]["density"] ?? "";

        modeResult.value =
            result["data"]["mode"] ?? "";

        if (selectedMode.value == "hybrid") {

          motifName.value =
              result["data"]["motif"] ?? "";

        } else {

          motifName.value = "";
        }

        print(
          "IMAGE : ${generatedImage.value}",
        );

        print(
          "MODE : ${modeResult.value}",
        );

        print(
          "MOTIF : ${motifName.value}",
        );

        Get.snackbar(

          "Success",

          "Motif berhasil dibuat",

          backgroundColor:
              Colors.green,

          colorText:
              Colors.white,
        );

      } else {

        Get.snackbar(

          "Error",

          result["message"] ??
              "Terjadi kesalahan",

          backgroundColor:
              Colors.red,

          colorText:
              Colors.white,
        );
      }

    } catch (e) {

      print(
        "Generate Error : $e",
      );

      Get.snackbar(

        "Error",

        e.toString(),

        backgroundColor:
            Colors.red,

        colorText:
            Colors.white,
      );

    } finally {

      isLoading.value = false;
    }
  }

Future<void> saveDesign()
async {

  try {

    final result =
        await DesignService.saveDesign(

      mode:
          modeResult.value,

      motifName:
          motifName.value,

      prompt:
          promptController.text,

      imageUrl:
          generatedImage.value,

      philosophy:
          philosophy.value,

      density:
          density.value,
    );

    if (result["success"]) {

      Get.snackbar(

        "Success",

        "Design berhasil disimpan",

        backgroundColor:
            Colors.green,

        colorText:
            Colors.white,
      );

    } else {

      Get.snackbar(

        "Error",

        result["message"],

        backgroundColor:
            Colors.red,

        colorText:
            Colors.white,
      );
    }

  } catch (e) {

    Get.snackbar(

      "Error",

      e.toString(),

      backgroundColor:
          Colors.red,

      colorText:
          Colors.white,
    );
  }
}
  // ================= RESET =================

  void resetForm() {

    promptController.clear();

    generatedImage.value = "";

    philosophy.value = "";

    density.value = "";

    motifName.value = "";

    modeResult.value = "";
  }

  // ================= DISPOSE =================

  @override
  void onClose() {

    promptController.dispose();

    super.onClose();
  }
}