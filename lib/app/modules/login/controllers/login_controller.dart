import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email & Password wajib diisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // ✅ Menggunakan ApiService terpusat
      final response = await ApiService.loginUser(
        emailController.text,
        passwordController.text,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          responseData['pesan'] ?? "Login berhasil 🚀",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          "Error",
          responseData['pesan'] ?? "Email atau kata sandi salah",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Tidak dapat terhubung ke server",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
