import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../navbar/controllers/navbar_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final navbarController =
      Get.find<NavbarController>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),

        // ================= BOTTOM NAVIGATION =================

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                // ================= HEADER =================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [

                    // LOGO

                    Row(
                      children: [

                        Image.asset(
                          "assets/logo.jpeg",
                          width: 45,
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "BatikFly",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // PROFILE

                    Row(
                      children: [

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.end,
                          children: const [

                            Text(
                              "Halo,",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),

                            Text(
                              "Adelia!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            navbarController.changeIndex(4);
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // ================= BANNER =================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1B2240),
                        Color(0xFF252D52),
                      ],
                    ),
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "BUAT BATIK\nIMPIANMU",
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 30,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Desain & Fitting 3D Sendiri!",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.amber,
                                foregroundColor:
                                    Colors.black,
                              ),
                              onPressed: () {
                                navbarController.changeIndex(1);
                              },
                              icon: const Icon(
                                Icons.brush,
                              ),
                              label: const Text(
                                "Mulai Desain",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        width: 100,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.checkroom,
                          color: Colors.amber,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ================= FITUR =================

                const Text(
                  "FITUR UTAMA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
  children: [

    // FITTING 3D
    Expanded(
      child: GestureDetector(
        onTap: () {
          navbarController.changeIndex(2);
        },
        child: featureCard(
          Icons.camera_alt,
          "Fitting 3D",
          "Kamera AI",
        ),
      ),
    ),

    const SizedBox(width: 15),

    // GALERI
    Expanded(
      child: GestureDetector(
        onTap: () {
            navbarController.changeIndex(3);
        },
        child: featureCard(
          Icons.brush,
          "Desain",
          "Motif AI",
        ),
      ),
    ),
  ],
),

const SizedBox(height: 30),

                const SizedBox(height: 30),

                // ================= INSPIRASI =================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [

                    Text(
                      "JELAJAHI BATIK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [

                      batikCard(
                        "Batik Semen Modern",
                      ),

                      const SizedBox(width: 15),

                      batikCard(
                        "Batik Kawung Chic",
                      ),

                      const SizedBox(width: 15),

                      batikCard(
                        "Batik Parang Elegant",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  // ================= FEATURE CARD =================

  Widget featureCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: Colors.amber,
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= BATIK CARD =================

  Widget batikCard(String title) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius:
                  BorderRadius.circular(25),
            ),
           child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                "assets/batik1.jpg",
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Oleh: Anya",
                  style: TextStyle(
                    color: Colors.white70,
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