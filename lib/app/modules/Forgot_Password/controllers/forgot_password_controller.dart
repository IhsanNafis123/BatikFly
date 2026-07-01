import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';
import '../../../config/api_config.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendResetPassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email tidak boleh kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(ApiConfig.forgotPassword),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
        }),
      );

      Map<String, dynamic> data = {};

      try {
        data = jsonDecode(response.body);
      } catch (_) {
        data = {
          "message": "Terjadi kesalahan pada server."
        };
      }

      if (response.statusCode == 200) {
        Get.snackbar(
          "Berhasil",
          data["message"] ?? "Token reset password berhasil dikirim ke email.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed(Routes.RESET_PASSWORD);
      } else {
        Get.snackbar(
          "Gagal",
          data["message"] ?? "Gagal mengirim token reset password.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Tidak dapat terhubung ke server.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}