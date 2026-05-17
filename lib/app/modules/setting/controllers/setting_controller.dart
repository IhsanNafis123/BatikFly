import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {

  var isDarkMode = false.obs;

  void changeTheme(bool value) {

    isDarkMode.value = value;

    Get.changeThemeMode(
      value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}