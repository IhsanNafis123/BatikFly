import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/api_config.dart';

class ProfileController extends GetxController {

  final box = GetStorage();

  RxBool isLoading = false.obs;

  RxString name = "".obs;
  RxString email = "".obs;
  RxString avatar = "".obs;
  RxString provider = "".obs;

  @override
  void onInit() {
    super.onInit();

    getProfile();
  }

  Future<void> getProfile() async {

    try {

      isLoading.value = true;

      final token =
          box.read("token");

      if (token == null) {

        Get.snackbar(
          "Error",
          "Token tidak ditemukan",
        );

        return;
      }

      final response = await http.get(

        Uri.parse(ApiConfig.profile),

        headers: {

          "Authorization":
              "Bearer $token",

          "Content-Type":
              "application/json",

        },

      );

      final data =
          jsonDecode(response.body);

      if (response.statusCode == 200) {

        name.value =
            data["name"] ?? "";

        email.value =
            data["email"] ?? "";

        avatar.value =
            data["avatar"] ?? "";

        provider.value =
            data["provider"] ?? "";

      } else {

        Get.snackbar(
          "Error",
          data["message"] ??
              "Gagal mengambil profile",
        );

      }

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

  Future<void> logout() async {

    await box.remove("token");
    await box.remove("user");

    Get.offAllNamed("/login");
  }
}