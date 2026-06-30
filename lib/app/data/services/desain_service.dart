import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

class DesignService {
  // ================= GENERATE DESIGN =================

  static Future<Map<String, dynamic>> generateDesign({
    required String mode,
    required String prompt,
    String? baseMotif,
  }) async {
    final Map<String, dynamic> body = {
      "mode": mode,
      "prompt": prompt,
    };

    // Hanya tambahkan base_motif jika mode Hybrid
    if (mode == "hybrid" &&
        baseMotif != null &&
        baseMotif.isNotEmpty) {
      body["base_motif"] = baseMotif;
    }

    final response = await http.post(
      Uri.parse(ApiConfig.generateDesign),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        data["message"] ?? "Generate design gagal",
      );
    }

    return data;
  }

  // ================= GET MOTIFS =================

  static Future<List<String>> getMotifs() async {
    final response = await http.get(
      Uri.parse(ApiConfig.getMotifs),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        data["message"] ?? "Gagal mengambil data motif",
      );
    }

    return List<String>.from(
      data["data"] ?? [],
    );
  }

  // ================= SAVE DESIGN =================

  static Future<Map<String, dynamic>> saveDesign({
    required String mode,
    required String motifName,
    required String prompt,
    required String imageUrl,
    required String philosophy,
    required String density,
  }) async {
    final box = GetStorage();

    final token = box.read("token");

    if (token == null) {
      throw Exception("User belum login");
    }

    final response = await http.post(
      Uri.parse(ApiConfig.saveDesign),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "mode": mode,
        "motif_name": motifName,
        "prompt": prompt,
        "image_url": imageUrl,
        "philosophy": philosophy,
        "density": density,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        data["message"] ?? "Gagal menyimpan desain",
      );
    }
    return data;
  }
}