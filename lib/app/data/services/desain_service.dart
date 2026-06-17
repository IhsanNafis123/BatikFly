import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class DesignService {
  static const String baseUrl =
      "http://192.168.57.180:5000";

  // ================= GENERATE DESIGN =================

  static Future<Map<String, dynamic>>
      generateDesign({

    required String mode,
    required String prompt,
    required String baseMotif,

  }) async {

    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/design/generate",
      ),

      headers: {
        "Content-Type":
            "application/json"
      },

      body: jsonEncode({

        "mode": mode,

        "prompt": prompt,

        "base_motif":
            baseMotif

      }),
    );

    return jsonDecode(
      response.body,
    );
  }

  // ================= GET MOTIFS =================

  static Future<List<String>>
      getMotifs() async {

    final response =
        await http.get(

      Uri.parse(
        "$baseUrl/motifs",
      ),
    );

    final data =
        jsonDecode(
            response.body);

    return List<String>.from(
        data["data"]);
  }

  // ================= SAVE DESIGN =================

  static Future<Map<String, dynamic>>
      saveDesign({

    required String mode,

    required String motifName,

    required String prompt,

    required String imageUrl,

    required String philosophy,

    required String density,

  }) async {

    final box = GetStorage();

    final token =
        box.read("token");

    print(
      "JWT TOKEN = $token",
    );

    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/design/save",
      ),

      headers: {

        "Content-Type":
            "application/json",

        "Authorization":
            "Bearer $token"
      },

      body: jsonEncode({

        "mode":
            mode,

        "motif_name":
            motifName,

        "prompt":
            prompt,

        "image_url":
            imageUrl,

        "philosophy":
            philosophy,

        "density":
            density

      }),
    );

    return jsonDecode(
      response.body,
    );
  }
}