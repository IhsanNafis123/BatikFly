import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {

  if (emailController.text.isEmpty ||
      passwordController.text.isEmpty) {

    Get.snackbar(
      "Error",
      "Email & Password wajib diisi",
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

  // LOGIN VALIDATION
  if (emailController.text == "1" &&
      passwordController.text == "1") {

    // SUCCESS
    Get.snackbar(
      "Success",
      "Login berhasil 🚀",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // PINDAH KE HOME
    Get.offAllNamed(Routes.HOME);

  } else {

    // FAILED
    Get.snackbar(
      "Error",
      "Email atau kata sandi salah",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
}