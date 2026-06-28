import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../config/api_config.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  // ==========================
  // LOADING
  // ==========================

  final isLoading = false.obs;

  // ==========================
  // PROFILE
  // ==========================

  final username = "".obs;
  final email = "".obs;
  final avatar = "".obs;
  final provider = "".obs;
  final joinDate = "".obs;

  // ==========================
  // STATISTIC
  // ==========================

  final totalDesign = 0.obs;
  final totalFitting = 0.obs;
  final totalDownload = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      final token = box.read("token");

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
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          body["success"] == true) {

        final data = body["data"];

        username.value = data["name"] ?? "";
        email.value = data["email"] ?? "";
        avatar.value = data["avatar"] ?? "";
        provider.value = data["provider"] ?? "";

        totalDesign.value =
            data["total_design"] ?? 0;

        totalFitting.value =
            data["total_fitting"] ?? 0;

        totalDownload.value =
            data["total_download"] ?? 0;

        if (data["created_at"] != null &&
            data["created_at"].toString().isNotEmpty) {

          final date = DateTime.parse(
            data["created_at"],
          );

          joinDate.value = DateFormat(
            "dd MMMM yyyy",
            "id_ID",
          ).format(date);

        } else {

          joinDate.value = "-";

        }

      } else {

        Get.snackbar(
          "Error",
          body["message"] ??
              "Gagal mengambil profile",
        );

      }

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value = false;

    }
  }

  Future<void> refreshProfile() async {
    await getProfile();
  }

  Future<void> logout() async {
    await box.erase();
    Get.offAllNamed("/login");
  }
}