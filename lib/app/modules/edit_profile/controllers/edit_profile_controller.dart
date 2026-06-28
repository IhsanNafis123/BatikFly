import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../config/api_config.dart';

class EditProfileController extends GetxController {

  final box = GetStorage();

  final picker = ImagePicker();

  // ==========================
  // LOADING
  // ==========================

  final isLoading = false.obs;

  // ==========================
  // PROFILE
  // ==========================

  final avatar = "".obs;
  final email = "".obs;
  final provider = "".obs;

  final selectedImage = Rx<File?>(null);

  // ==========================
  // TEXT CONTROLLER
  // ==========================

  final usernameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final oldPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  // ==========================
  // GET PROFILE
  // ==========================

  Future<void> getProfile() async {

    try {

      isLoading.value = true;

      final token = box.read("token");

      final response = await http.get(

        Uri.parse(ApiConfig.profile),

        headers: {

          "Authorization":
              "Bearer $token",

          "Content-Type":
              "application/json",

        },

      );

      final body =
          jsonDecode(response.body);

      if (response.statusCode == 200 &&
          body["success"] == true) {

        final data = body["data"];

        usernameController.text =
            data["name"] ?? "";

        emailController.text =
            data["email"] ?? "";

        email.value =
            data["email"] ?? "";

        avatar.value =
            data["avatar"] ?? "";

        provider.value =
            data["provider"] ?? "";

      } else {

        Get.snackbar(
          "Error",
          body["message"],
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

  // ==========================
  // PICK IMAGE
  // ==========================

  Future<void> pickImage() async {

    final XFile? image =
        await picker.pickImage(

      source: ImageSource.gallery,

      imageQuality: 80,

    );

    if (image != null) {

      selectedImage.value =
          File(image.path);

    }

  }

  // ==========================
  // SAVE PROFILE
  // ==========================

  Future<void> saveProfile() async {

    if (usernameController.text.isEmpty) {

      Get.snackbar(
        "Error",
        "Username tidak boleh kosong",
      );

      return;

    }

    if (provider.value != "google") {

      if (emailController.text.isEmpty) {

        Get.snackbar(
          "Error",
          "Email tidak boleh kosong",
        );

        return;

      }

      if (newPasswordController
              .text.isNotEmpty &&
          newPasswordController.text !=
              confirmPasswordController
                  .text) {

        Get.snackbar(
          "Error",
          "Konfirmasi password tidak sama",
        );

        return;

      }

    }

    Get.dialog(

      const Center(
        child:
            CircularProgressIndicator(),
      ),

      barrierDismissible: false,

    );

    try {

      final token =
          box.read("token");

      final request = http.MultipartRequest(

        "PUT",

        Uri.parse(
          ApiConfig.updateProfile,
        ),

      );

      request.headers["Authorization"] =
          "Bearer $token";

      request.fields["name"] =
          usernameController.text;

      if (provider.value != "google") {

        request.fields["email"] =
            emailController.text;

        request.fields["old_password"] =
            oldPasswordController.text;

        request.fields["new_password"] =
            newPasswordController.text;

      }

      if (selectedImage.value != null) {

        request.files.add(

          await http.MultipartFile
              .fromPath(

            "avatar",

            selectedImage.value!.path,

          ),

        );

      }

      final response =
          await request.send();

      final result =
          jsonDecode(

        await response.stream.bytesToString(),

      );

      Get.back();

      if (response.statusCode == 200) {

        Get.snackbar(

          "Berhasil",

          result["message"],

        );

        Get.back(result: true);

      } else {

        Get.snackbar(

          "Error",

          result["message"],

        );

      }

    } catch (e) {

      Get.back();

      Get.snackbar(

        "Error",

        e.toString(),

      );

    }

  }

  @override
  void onClose() {

    usernameController.dispose();

    emailController.dispose();

    oldPasswordController.dispose();

    newPasswordController.dispose();

    confirmPasswordController.dispose();

    super.onClose();

  }

}