import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text("Keluar"),
          ],
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari akun BatikFly?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: logout,
            child: const Text("Keluar"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> logout() async {
    Get.back();

    await box.erase();

    Get.offAllNamed("/login");
  }
}