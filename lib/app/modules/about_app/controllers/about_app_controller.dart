import 'package:get/get.dart';

class AboutAppController extends GetxController {

  // ==========================
  // APP INFORMATION
  // ==========================

  final appName = "BatikFly".obs;

  final version = "1.0.0".obs;

  final developer = "Capstone Project".obs;

  final university = "Universitas Harapan Bersama".obs;

  final studyProgram = "D4 Teknik Informatika".obs;

  final copyright =
      "© 2026 BatikFly\nAll Rights Reserved."
          .obs;

  // ==========================
  // DESCRIPTION
  // ==========================

  final description =
      '''
BatikFly merupakan aplikasi berbasis Artificial Intelligence yang membantu pengguna dalam merancang motif batik, melakukan Virtual Fitting, mengelola galeri desain, serta mengunduh hasil desain secara cepat dan mudah.

Aplikasi ini dikembangkan sebagai bagian dari Capstone Project untuk mendukung pelestarian budaya batik Indonesia melalui teknologi modern.
'''
          .obs;

  // ==========================
  // FEATURE LIST
  // ==========================

  final features = [

    {
      "title": "AI Batik Generator",
      "description":
          "Menghasilkan desain batik menggunakan Artificial Intelligence."
    },

    {
      "title": "Virtual Fitting",
      "description":
          "Mencoba desain batik secara virtual sebelum diproduksi."
    },

    {
      "title": "Galeri Desain",
      "description":
          "Menyimpan seluruh hasil desain pengguna."
    },

    {
      "title": "Download",
      "description":
          "Mengunduh desain dan hasil fitting dengan mudah."
    },

    {
      "title": "Keamanan Akun",
      "description":
          "Login Email, Google Login, dan JWT Authentication."
    },

  ].obs;

  // ==========================
  // TECHNOLOGY
  // ==========================

  final technologies = [

    "Flutter",

    "Flask",

    "Supabase",

    "Google Gemini",

    "FAL AI",

    "Artificial Intelligence",

  ].obs;

}