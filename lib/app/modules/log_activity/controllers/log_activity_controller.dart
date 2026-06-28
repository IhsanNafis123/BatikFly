import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config/api_config.dart';

class LogActivityController extends GetxController {

  final box = GetStorage();

  final isLoading = false.obs;

  final activities = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getActivities();
  }

  Future<void> getActivities() async {

    try {

      isLoading.value = true;

      final token = box.read("token");

      final response = await http.get(

        Uri.parse(ApiConfig.activityLogs),

        headers: {

          "Authorization": "Bearer $token",

          "Content-Type": "application/json",

        },

      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          body["success"] == true) {

        activities.assignAll(
          body["data"],
        );

      } else {

        Get.snackbar(
          "Error",
          body["message"],
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

  Future<void> refreshData() async {

    await getActivities();

  }

}