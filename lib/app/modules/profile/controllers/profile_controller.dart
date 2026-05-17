import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  // ================= BTF043 =================
  // FOTO PROFIL

  RxString profileImage =
      "assets/profile.jpg".obs;

  // ================= BTF044 =================
  // NAMA PENGGUNA

  RxString username =
      "Adelia Putri".obs;

  // ================= BTF045 =================
  // EMAIL PENGGUNA

  RxString email =
      "adelia@batikfly.com".obs;

  // ================= BTF046 =================
  // TOTAL DESAIN

  RxInt totalDesign = 24.obs;

  // ================= BTF047 =================
  // GALERI FAVORIT

  RxInt totalGallery = 12.obs;

  // ================= BTF048 =================
  // STYLE FAVORIT

  RxString favoriteStyle =
      "Mega Mendung Modern".obs;

  // ================= BTF050 =================
  // EDIT PROFIL

  void editProfile() {

    Get.defaultDialog(
      title: "Edit Profil",

      middleText:
          "Fitur edit profil berhasil dibuka",

      backgroundColor:
          const Color(0xFF1A1F3A),

      titleStyle:
          const TextStyle(
        color: Colors.white,
      ),

      middleTextStyle:
          const TextStyle(
        color: Colors.white70,
      ),

      textConfirm: "OK",

      confirmTextColor:
          Colors.white,

      buttonColor:
          Colors.blue,
    );
  }

  // ================= BTF049 =================
  // LOGOUT

  void logout() {

    Get.defaultDialog(
      title: "Logout",

      middleText:
          "Yakin ingin keluar?",

      backgroundColor:
          const Color(0xFF1A1F3A),

      titleStyle:
          const TextStyle(
        color: Colors.white,
      ),

      middleTextStyle:
          const TextStyle(
        color: Colors.white70,
      ),

      textCancel: "Batal",
      textConfirm: "Logout",

      confirmTextColor:
          Colors.white,

      buttonColor:
          Colors.red,

      onConfirm: () {

        Get.offAllNamed(
          Routes.LOGIN,
        );
      },
    );
  }
}