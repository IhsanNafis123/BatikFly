import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(

        title: const Text(
          "Kebijakan Privasi",
        ),

        centerTitle: true,

        backgroundColor: const Color(0xff8B4513),

        foregroundColor: Colors.white,

        elevation: 0,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(22),

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

              child: Column(

                children: [

                  CircleAvatar(

                    radius: 35,

                    backgroundColor:
                        Colors.brown.shade100,

                    child: const Icon(

                      Icons.privacy_tip,

                      size: 38,

                      color: Color(0xff8B4513),

                    ),

                  ),

                  const SizedBox(height: 18),

                  const Text(

                    "Privasi Anda Penting Bagi Kami",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontSize: 22,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 12),

                  Text(

                    "BatikFly berkomitmen untuk melindungi data pribadi setiap pengguna. Kebijakan privasi ini menjelaskan bagaimana informasi dikumpulkan, digunakan, dan dilindungi selama Anda menggunakan aplikasi.",

                    textAlign: TextAlign.justify,

                    style: TextStyle(

                      color: Colors.grey.shade700,

                      height: 1.7,

                      fontSize: 15,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 30),

            const Text(

              "Informasi yang Dikumpulkan",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

            _buildPolicyCard(

              icon: Icons.person,

              color: Colors.blue,

              title: "Informasi Akun",

              description:
                  "Kami menyimpan informasi seperti nama, alamat email, foto profil, dan metode login (Email atau Google) untuk proses autentikasi dan personalisasi akun.",

            ),

            const SizedBox(height: 15),

            _buildPolicyCard(

              icon: Icons.image,

              color: Colors.orange,

              title: "Desain Batik",

              description:
                  "Desain batik, hasil Virtual Fitting, dan gambar yang diunggah pengguna disimpan agar dapat diakses kembali melalui galeri aplikasi.",

            ),

            const SizedBox(height: 30),

            //=================================
            // PART 2 DIMULAI DARI SINI
            //=================================
                        const Text(

              "Penggunaan Data",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

            _buildPolicyCard(

              icon: Icons.analytics_outlined,

              color: Colors.green,

              title: "Penggunaan Informasi",

              description:
                  "Informasi yang dikumpulkan digunakan untuk proses autentikasi akun, menghasilkan desain batik berbasis Artificial Intelligence, Virtual Fitting, menyimpan riwayat aktivitas, serta meningkatkan kualitas layanan BatikFly.",

            ),

            const SizedBox(height: 15),

            _buildPolicyCard(

              icon: Icons.storage,

              color: Colors.deepPurple,

              title: "Penyimpanan Data",

              description:
                  "Data pengguna disimpan secara aman menggunakan Supabase Cloud Database dan Supabase Storage. Seluruh komunikasi dilakukan melalui koneksi HTTPS yang terenkripsi.",

            ),

            const SizedBox(height: 15),

            _buildPolicyCard(

              icon: Icons.security,

              color: Colors.red,

              title: "Keamanan Data",

              description:
                  "Kami menerapkan autentikasi JWT, login Google, serta mekanisme keamanan lainnya untuk membantu melindungi akun dan informasi pribadi pengguna dari akses yang tidak sah.",

            ),

            const SizedBox(height: 15),

            _buildPolicyCard(

              icon: Icons.cloud_outlined,

              color: Colors.teal,

              title: "Layanan Pihak Ketiga",

              description:
                  "BatikFly menggunakan layanan pihak ketiga seperti Google Sign-In, Google Gemini AI, FAL AI, dan Supabase untuk mendukung proses autentikasi, penyimpanan data, serta pembuatan desain berbasis Artificial Intelligence.",

            ),

            const SizedBox(height: 30),

            const Text(

              "Hak Pengguna",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

            _buildPolicyCard(

              icon: Icons.manage_accounts,

              color: Colors.indigo,

              title: "Kontrol Data",

              description:
                  "Pengguna berhak memperbarui informasi akun, mengganti foto profil, mengubah kata sandi (akun lokal), serta menghapus akun sesuai kebijakan yang berlaku.",

            ),

            const SizedBox(height: 30),

            //=================================
            // PART 3 DIMULAI DARI SINI
            //=================================
                        const Text(

              "Perubahan Kebijakan",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

            _buildPolicyCard(

              icon: Icons.update,

              color: Colors.orange,

              title: "Perubahan Kebijakan Privasi",

              description:
                  "Kebijakan privasi ini dapat diperbarui sewaktu-waktu untuk menyesuaikan perkembangan fitur, teknologi, maupun ketentuan hukum yang berlaku. Setiap perubahan akan berlaku setelah dipublikasikan pada aplikasi BatikFly.",

            ),

            const SizedBox(height: 30),

            const Text(

              "Hubungi Kami",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 18),

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

                  ),

                ],

              ),

              child: Column(

                children: [

                  CircleAvatar(

                    radius: 35,

                    backgroundColor:
                        Colors.brown.shade100,

                    child: const Icon(

                      Icons.support_agent,

                      color: Color(0xff8B4513),

                      size: 35,

                    ),

                  ),

                  const SizedBox(height: 15),

                  const Text(

                    "Tim BatikFly",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 8),

                  const Text(

                    "Email",

                    style: TextStyle(

                      fontWeight: FontWeight.w600,

                    ),

                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "support@batikfly.id",
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  const SizedBox(height: 15),

                  const Text(

                    "Universitas Harapan Bersama",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 5),

                  const Text(

                    "Capstone Project\nD4 Teknik Informatika",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      color: Colors.grey,

                      height: 1.6,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 40),

            const Divider(),

            const SizedBox(height: 20),

            Icon(

              Icons.verified_user,

              size: 40,

              color: Colors.green,

            ),

            const SizedBox(height: 15),

            const Text(

              "Terima kasih telah mempercayai BatikFly.",

              textAlign: TextAlign.center,

              style: TextStyle(

                fontSize: 17,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            Text(

              "Kami berkomitmen menjaga keamanan dan privasi data setiap pengguna selama menggunakan aplikasi BatikFly.",

              textAlign: TextAlign.center,

              style: TextStyle(

                color: Colors.grey.shade700,

                height: 1.6,

              ),

            ),

            const SizedBox(height: 30),

            const Text(

              "© 2026 BatikFly\nAll Rights Reserved.",

              textAlign: TextAlign.center,

              style: TextStyle(

                color: Colors.grey,

                height: 1.6,

              ),

            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }

  //=================================
  // PART 4 DIMULAI DARI SINI
  //=================================
  Widget _buildPolicyCard({
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey.shade700,
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