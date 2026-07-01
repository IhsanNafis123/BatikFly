import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/api_config.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print("===== LoginController dibuat =====");
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  // ==========================
  // LOGIN EMAIL & PASSWORD
  // ==========================
  Future<void> login() async {
      print("====================================");
      print("LOGIN DITEKAN");
      print("EMAIL    : '${emailController.text}'");
      print("PASSWORD : '${passwordController.text}'");
      print("EMAIL EMPTY    : ${emailController.text.trim().isEmpty}");
      print("PASSWORD EMPTY : ${passwordController.text.trim().isEmpty}");
      print("====================================");
      
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email dan Password wajib diisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(ApiConfig.login),

        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data["token"];
        final user = data["user"];

        final box = GetStorage();

        await box.write("token", token);

        await box.write("user", user);
        await box.write("user_id", user["id"]);

        Get.snackbar(
          "Success",
          data["message"] ?? "Login berhasil",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.NAVBAR);
      } else {
        Get.snackbar(
          "Login Gagal",
          data["message"] ?? "Email atau Password salah",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  // ==========================
  // LOGIN GOOGLE
  // ==========================
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '921926659146-pt491l9jto816djrvpmd8pfl47tuhjb3.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) return;

      final GoogleSignInAuthentication auth = await account.authentication;

      final String? idToken = auth.idToken;

      if (idToken == null) {
        Get.snackbar("Error", "Google Token tidak ditemukan");

        return;
      }

      final response = await http.post(
        Uri.parse(ApiConfig.googleLogin),

        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id_token": idToken}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data["token"];
        final user = data["user"];

        final box = GetStorage();

        await box.write("token", token);

        await box.write("user", user);
        await box.write("user_id", user["id"]);

        Get.snackbar(
          "Success",
          "Login Google berhasil",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.NAVBAR);
      } else {
        Get.snackbar("Error", data["message"] ?? "Login Google gagal");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
  if (email.trim().isEmpty) {
    Get.snackbar(
      "Error",
      "Masukkan email terlebih dahulu",
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
        "email": email.trim(),
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.snackbar(
        "Berhasil",
        data["message"],
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Gagal",
        data["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    if (!isClosed) {
      isLoading.value = false;
    }
  }
}

  // ==========================
  // LOGOUT
  // ==========================
  Future<void> logout() async {
    final box = GetStorage();

    await box.remove("token");
    await box.remove("user");
    await box.remove("user_id");

    Get.offAllNamed(Routes.LOGIN);

    Get.snackbar(
      "Success",
      "Logout berhasil",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
