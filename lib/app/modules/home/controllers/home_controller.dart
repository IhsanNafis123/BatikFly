import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../config/api_config.dart';

class HomeController extends GetxController {
  var userName = 'Kreator'.obs;
  var userAvatar = ''.obs;

  // Variabel untuk Tren TikTok
  var tiktokViral = <Map<String, dynamic>>[].obs;
  var trendingMotifs = <Map<String, dynamic>>[].obs;
  var communityTrends = <Map<String, dynamic>>[].obs;
  var latestArticles = <Map<String, dynamic>>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    fetchHomeTrends();
  }

  void loadUserProfile() {
    final box = GetStorage();
    final user = box.read('user');
    if (user != null) {
      userName.value = user['name'] ?? 'Kreator';
      userAvatar.value = user['avatar'] ?? '';
    }
  }

  Future<void> fetchHomeTrends() async {
    try {
      isLoading(true);
      final url = Uri.parse(ApiConfig.getHomeTrends);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> motifsRaw = data['data']['motifs'] ?? [];
          final List<dynamic> communityRaw = data['data']['community'] ?? [];
          final List<dynamic> articlesRaw = data['data']['articles'] ?? [];
          final List<dynamic> tiktokRaw = data['data']['tiktok_viral'] ?? [];

          trendingMotifs.assignAll(List<Map<String, dynamic>>.from(motifsRaw));
          communityTrends.assignAll(
            List<Map<String, dynamic>>.from(communityRaw),
          );
          latestArticles.assignAll(
            List<Map<String, dynamic>>.from(articlesRaw),
          );

          // === BARIS INI YANG SEBELUMNYA TERTINGGAL ===
          tiktokViral.assignAll(List<Map<String, dynamic>>.from(tiktokRaw));
        }
      }
    } catch (e) {
      debugPrint("ERROR Fetch Home Trends: $e");
    } finally {
      isLoading(false);
    }
  }
}
