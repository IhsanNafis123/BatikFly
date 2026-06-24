import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Loading State
  RxBool isLoading = false.obs;

  // Ganti dengan URL backend Flask kamu
  static const String baseUrl =
      "http://192.168.101.76:5000";

  Future<void> register() async {
    try {
      // Validasi Nama
      if (nameController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Nama lengkap wajib diisi",
        );
        return;
      }

      // Validasi Email
      if (emailController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Email wajib diisi",
        );
        return;
      }

      if (!GetUtils.isEmail(
        emailController.text.trim(),
      )) {
        Get.snackbar(
          "Error",
          "Format email tidak valid",
        );
        return;
      }

      // Validasi Password
      if (passwordController.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Password wajib diisi",
        );
        return;
      }

      if (passwordController.text.length < 8 ||
          passwordController.text.length > 12) {
        Get.snackbar(
          "Error",
          "Password harus 8-12 karakter",
        );
        return;
      }

      // Validasi Confirm Password
      if (confirmPasswordController.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Konfirmasi password wajib diisi",
        );
        return;
      }

      if (passwordController.text !=
          confirmPasswordController.text) {
        Get.snackbar(
          "Error",
          "Password tidak cocok",
        );
        return;
      }

      isLoading.value = true;

      final response = await http.post(
        Uri.parse(
          "$baseUrl/auth/register/request-otp",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        Get.snackbar(
          "Berhasil",
          data["message"] ??
              "Kode OTP telah dikirim ke email",
        );

        Get.toNamed(
          Routes.OTP,
          arguments: {
            "email": emailController.text.trim(),
          },
        );

      } else {
        Get.snackbar(
          "Gagal",
          data["message"] ??
              "Registrasi gagal",
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

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}