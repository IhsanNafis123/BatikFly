import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  // USER DATA
  RxString username =
      "Adelia Putri".obs;

  RxString email =
      "adelia@batikfly.com".obs;

  RxInt totalDesign = 24.obs;

  RxInt totalGallery = 12.obs;

  // LOGOUT
  void logout() {

    Get.defaultDialog(
      title: "Logout",

      middleText:
          "Yakin ingin keluar?",

      backgroundColor:
          const Color(0xFF1A1F3A),

      titleStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
      ),

      middleTextStyle:
          const TextStyle(
        color: Color(0xFFBDBDBD),
      ),

      textCancel: "Batal",
      textConfirm: "Logout",

      confirmTextColor:
          const Color(0xFFFFFFFF),

      onConfirm: () {

        Get.offAllNamed(
          Routes.LOGIN,
        );
      },
    );
  }
}