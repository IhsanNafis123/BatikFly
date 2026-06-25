import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  RxBool isLoading = false.obs;

  static const String baseUrl =
      "http://192.168.110.225:5000";

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments["email"] ?? "";
  }

  Future<void> verifyOtp() async {
    try {
      if (otpController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Kode OTP wajib diisi",
        );
        return;
      }

      isLoading.value = true;

      final response = await http.post(
        Uri.parse(
          "$baseUrl/auth/register/verify-otp",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "otp": otpController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar(
          "Berhasil",
          data["message"] ??
              "Akun berhasil diverifikasi",
        );

        isLoading.value = false;

        Get.offAllNamed(
          Routes.LOGIN,
        );

        return;
      }

      Get.snackbar(
        "Gagal",
        data["message"] ??
            "OTP tidak valid",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}