import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView
    extends GetView<ProfileController> {

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light,
      ),

      child: Scaffold(
        backgroundColor:
            const Color(0xFF0D0F1A),

        

       // ================= NAVBAR =================

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4, // Indeks 4 untuk halaman Profil
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF15192F),
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            
            // Cegah reload jika menekan tab halaman saat ini (Profil)
            if (index == 4) return;

            // Navigasi menggunakan switch-case agar rapi dan lengkap
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME);
                break;
              case 1:
                Get.offAllNamed(Routes.DESAIN);
                break;
              case 2:
                Get.offAllNamed(Routes.FITTING);
                break;
              case 3:
                Get.offAllNamed(Routes.GALLERY);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.brush),
              label: 'Desain',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checkroom),
              label: 'Fitting', // Disesuaikan agar seragam
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), // Disesuaikan dengan icon di GalleryView
              label: 'Artikel', // Disesuaikan agar seragam
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              children: [

                // ================= HEADER =================

                Row(
                  children: [

                    Image.asset(
                      "assets/logo.jpeg",
                      width: 40,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    const Text(
                      "BatikFly",
                      style: TextStyle(
                        color:
                            Colors.amber,

                        fontSize: 28,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // ================= PROFILE IMAGE =================

                const CircleAvatar(
                  radius: 55,

                  backgroundColor:
                      Colors.amber,

                  child: Icon(
                    Icons.person,

                    size: 60,

                    color: Colors.black,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ================= USERNAME =================

                Obx(
                  () => Text(
                    controller
                        .username.value,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // ================= EMAIL =================

                Obx(
                  () => Text(
                    controller.email.value,

                    style: const TextStyle(
                      color:
                          Colors.white70,

                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                // ================= CARD =================

                Obx(
                  () => profileCard(
                    Icons.auto_awesome,

                    "Total Desain",

                    "${controller.totalDesign.value} Motif Batik",
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                Obx(
                  () => profileCard(
                    Icons.bookmark,

                    "Galeri Tersimpan",

                    "${controller.totalGallery.value} Desain Favorit",
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                profileCard(
                  Icons.palette,

                  "Style Favorit",

                  "Mega Mendung Modern",
                ),

                const SizedBox(
                  height: 35,
                ),

                // ================= LOGOUT BUTTON =================

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child:
                      ElevatedButton.icon(

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          Colors.red,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed:
                        controller.logout,

                    icon: const Icon(
                      Icons.logout,
                    ),

                    label: const Text(
                      "LOGOUT",

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= PROFILE CARD =================

  Widget profileCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
            const Color(0xFF1A1F3A),

        borderRadius:
            BorderRadius.circular(
          22,
        ),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                Colors.amber,

            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Colors.white,

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,

                  style: const TextStyle(
                    color:
                        Colors.white70,
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