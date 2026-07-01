import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/api_config.dart';
import '../../../routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> resetPassword() async {
    if (tokenController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Semua field wajib diisi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Konfirmasi password tidak sama.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.length < 8 ||
        passwordController.text.length > 12) {
      Get.snackbar(
        "Error",
        "Password harus 8-12 karakter.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(ApiConfig.resetPassword),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "token": tokenController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Berhasil",
          data["message"] ?? "Password berhasil diperbarui.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        tokenController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          "Gagal",
          data["message"] ?? "Reset password gagal.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
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
    tokenController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}