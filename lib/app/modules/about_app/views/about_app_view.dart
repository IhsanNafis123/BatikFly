import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/about_app_controller.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(

        title: const Text(
          "Tentang Aplikasi",
        ),

        centerTitle: true,

        elevation: 0,

        backgroundColor: const Color(0xff8B4513),

        foregroundColor: Colors.white,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            //====================================
            // LOGO
            //====================================

            Container(

              width: 120,

              height: 120,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(30),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withOpacity(.08),

                    blurRadius: 15,

                    offset: const Offset(0, 8),

                  )

                ],

              ),

              child: Padding(

                padding: const EdgeInsets.all(18),

                child: Image.asset(

                  "assets/logo dalam.png",

                  fit: BoxFit.contain,

                ),

              ),

            ),

            const SizedBox(height: 25),

            Obx(() => Text(

                  controller.appName.value,

                  style: const TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                  ),

                )),

            const SizedBox(height: 8),

            Obx(() => Container(

                  padding: const EdgeInsets.symmetric(

                    horizontal: 15,

                    vertical: 6,

                  ),

                  decoration: BoxDecoration(

                    color: Colors.brown.shade100,

                    borderRadius:
                        BorderRadius.circular(20),

                  ),

                  child: Text(

                    "Version ${controller.version.value}",

                    style: const TextStyle(

                      fontWeight: FontWeight.w600,

                    ),

                  ),

                )),

            const SizedBox(height: 30),

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withOpacity(.05),

                    blurRadius: 10,

                    offset: const Offset(0, 5),

                  )

                ],

              ),

              child: const Text(

                "BatikFly merupakan aplikasi berbasis Artificial Intelligence yang membantu pengguna dalam merancang motif batik, melakukan Virtual Fitting, mengelola galeri desain, serta mengunduh hasil desain secara cepat dan mudah. Aplikasi ini dikembangkan sebagai bagian dari Capstone Project untuk mendukung pelestarian budaya batik Indonesia melalui teknologi modern.",

                textAlign: TextAlign.justify,

                style: TextStyle(

                  fontSize: 15,
                  height: 1.9,
                  letterSpacing: 0.3,

                ),

              ),

            ),

            const SizedBox(height: 30),

            //==============================
            // PART 2 DIMULAI DARI SINI
            //==============================
                        const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fitur Utama",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildFeatureCard(
              icon: Icons.auto_awesome,
              color: Colors.deepPurple,
              title: "AI Batik Generator",
              description:
                  "Menghasilkan desain batik unik menggunakan Artificial Intelligence berdasarkan filosofi, motif, dan warna pilihan pengguna.",
            ),

            const SizedBox(height: 15),

            _buildFeatureCard(
              icon: Icons.checkroom,
              color: Colors.orange,
              title: "Virtual Fitting",
              description:
                  "Mencoba desain batik secara virtual sehingga pengguna dapat melihat hasil sebelum diproduksi.",
            ),

            const SizedBox(height: 15),

            _buildFeatureCard(
              icon: Icons.photo_library_outlined,
              color: Colors.blue,
              title: "Galeri Desain",
              description:
                  "Seluruh desain yang telah dibuat tersimpan secara otomatis sehingga mudah diakses kembali kapan saja.",
            ),

            const SizedBox(height: 15),

            _buildFeatureCard(
              icon: Icons.download_rounded,
              color: Colors.green,
              title: "Download Hasil",
              description:
                  "Mengunduh hasil desain maupun Virtual Fitting dengan kualitas tinggi untuk kebutuhan produksi maupun dokumentasi.",
            ),

            const SizedBox(height: 15),

            _buildFeatureCard(
              icon: Icons.security,
              color: Colors.red,
              title: "Keamanan Akun",
              description:
                  "Menggunakan autentikasi JWT, login Google, dan sistem keamanan modern untuk melindungi data pengguna.",
            ),

            const SizedBox(height: 35),

            //====================================
            // PART 3 DIMULAI DARI SINI
            //====================================
                        const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Developer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                children: const [

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xff8B4513),
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Capstone Project",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Universitas Harapan Bersama",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Program Studi D4 Teknik Informatika",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      height: 1.7,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 35),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Teknologi",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [

                Chip(
                  avatar: Icon(Icons.phone_android),
                  label: Text("Flutter"),
                ),

                Chip(
                  avatar: Icon(Icons.language),
                  label: Text("Flask"),
                ),

                Chip(
                  avatar: Icon(Icons.storage),
                  label: Text("Supabase"),
                ),

                Chip(
                  avatar: Icon(Icons.auto_awesome),
                  label: Text("Google Gemini"),
                ),

                Chip(
                  avatar: Icon(Icons.image),
                  label: Text("FAL AI"),
                ),

                Chip(
                  avatar: Icon(Icons.smart_toy),
                  label: Text("Artificial Intelligence"),
                ),

              ],
            ),

            const SizedBox(height: 40),

            Divider(),

            const SizedBox(height: 15),

            Icon(
              Icons.favorite,
              color: Colors.red.shade400,
            ),

            const SizedBox(height: 12),

            const Text(
              "BatikFly",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 5),

            Obx(
              () => Text(
                "Version ${controller.version.value}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "© 2026 BatikFly\nAll Rights Reserved.",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.8,
                    letterSpacing: 0.2,
                  ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }

  //====================================
  // PART 4 DIMULAI DARI SINI
  //====================================
  Widget _buildFeatureCard({
  required IconData icon,
  required Color color,
  required String title,
  required String description,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(.12),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                description,
                 textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.8,
                  letterSpacing: 0.2,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  );
}
}