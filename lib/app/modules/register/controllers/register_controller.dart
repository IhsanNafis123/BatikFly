import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart'; // Import service baru Anda

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    // Validasi panjang karakter 8 hingga 12 karakter
    if (passwordController.text.length < 8 || passwordController.text.length > 12) {
      Get.snackbar("Error", "Password harus 8 - 12 karakter", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Password tidak cocok", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // ✅ Cukup panggil ApiService di sini (Kode jadi sangat rapi)
      final response = await ApiService.registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar("Success", responseData['pesan'] ?? "Register berhasil", backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Error", responseData['pesan'] ?? "Gagal mendaftar", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}