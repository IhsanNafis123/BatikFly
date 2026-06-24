import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // ==========================
  // LOGIN EMAIL & PASSWORD
  // ==========================
  Future<void> login() async {
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
      Uri.parse(
        'http://192.168.101.76:5000/auth/login',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': emailController.text.trim(),
        'password': passwordController.text,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      final token = data["token"];

      final box = GetStorage();

      await box.write(
        "token",
        token,
      );

      Get.snackbar(
        "Success",
        data["message"] ??
            "Login berhasil",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(
        Routes.HOME,
      );

    } else {

      Get.snackbar(
        "Login Gagal",
        data["message"] ??
            "Email atau Password salah",
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

    isLoading.value = false;

  }
}

  // ==========================
  // LOGIN GOOGLE
  // ==========================
Future<void> loginWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(serverClientId:
      '921926659146-pt491l9jto816djrvpmd8pfl47tuhjb3.apps.googleusercontent.com',);

    final GoogleSignInAccount? account =
        await googleSignIn.signIn();

    if (account == null) return;

    final GoogleSignInAuthentication auth =
        await account.authentication;

    final String? idToken = auth.idToken;

    if (idToken == null) {
      Get.snackbar(
        "Error",
        "Google Token tidak ditemukan",
      );
      return;
    }

    final response = await http.post(
      Uri.parse(
        'http://192.168.101.76:5000/auth/google',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_token': idToken,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];

      final box = GetStorage();

      await box.write("token",token,);

      Get.snackbar(
        "Success",
        "Login Google berhasil",
      );

      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar(
        "Error",
        data['message'],
      );
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
    );
  }
}

  // ==========================
  // LOGOUT
  // ==========================
  Future<void> logout() async {

  final box = GetStorage();

  await box.remove("token");

  Get.offAllNamed(
    Routes.LOGIN,
  );

  Get.snackbar(
    "Success",
    "Logout berhasil",
  );
}
}