import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../navbar/views/navbar_view.dart';

class DesainView extends StatelessWidget {
  const DesainView({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),

      child: Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),

        // ================= NAVBAR =================

        bottomNavigationBar: const NavbarView(),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ================= HEADER =================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Row(
                      children: [

                        Image.asset(
                          "assets/logo.jpeg",
                          width: 35,
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "BatikFly",

                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Icon(
                      Icons.settings,
                      color: Colors.amber,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ================= TITLE =================

                const Text(
                  "Weave Your Vision",

                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Describe the patterns of your heritage,\nand let AI reveal the thread.",

                  style: TextStyle(
                    color: Colors.white54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                // ================= INPUT CARD =================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F3A),

                    borderRadius:
                        BorderRadius.circular(25),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // ================= TEXTFIELD =================

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF0D0F1A),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: const TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),

                          maxLines: 4,

                          decoration:
                              InputDecoration(
                            border: InputBorder.none,

                            hintText:
                                "e.g. Modern Mega Mendung in blue and gold",

                            hintStyle: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ================= BUTTON GENERATE =================

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.amber,

                            foregroundColor:
                                Colors.black,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                18,
                              ),
                            ),
                          ),

                          onPressed: () {

                            Get.snackbar(
                              "Success",
                              "Motif berhasil dibuat",

                              backgroundColor:
                                  Colors.green,

                              colorText:
                                  Colors.white,
                            );
                          },

                          icon: const Icon(
                            Icons.auto_awesome,
                          ),

                          label: const Text(
                            "GENERATE MOTIF",

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

                const SizedBox(height: 30),

                // ================= GENERATED TITLE =================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "GENERATED\nMASTERPIECE",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                        height: 1,
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.amber,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: const Text(
                        "TRADITIONAL\nAURIC",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= IMAGE =================

                Container(
                  width: double.infinity,
                  height: width * 0.8,

                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F3A),

                    borderRadius:
                        BorderRadius.circular(30),
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(30),

                    child: Image.asset(
                      "assets/batik_ai.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= BUTTONS =================

                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton.icon(
                        style:
                            OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.amber,
                          ),

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              16,
                            ),
                          ),
                        ),

                        onPressed: () {},

                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.amber,
                        ),

                        label: const Text(
                          "REGENERATE",

                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.amber,

                          foregroundColor:
                              Colors.black,

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              16,
                            ),
                          ),
                        ),

                        onPressed: () {

                          Get.snackbar(
                            "Saved",
                            "Motif disimpan ke galeri",

                            backgroundColor:
                                Colors.green,

                            colorText:
                                Colors.white,
                          );
                        },

                        icon: const Icon(
                          Icons.bookmark,
                        ),

                        label: const Text(
                          "SAVE TO\nGALLERY",

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ================= INFO CARD =================

                infoCard(
                  Icons.menu_book,
                  "Philosophy",

                  "The Mega Mendung motif represents the clouds of the heavy sky, symbolizing patience, calm, and the ability to maintain composure during tumultuous times.",
                ),

                const SizedBox(height: 20),

                infoCard(
                  Icons.graphic_eq,
                  "AI Weave Density",

                  "Processing with 95% relative weave layer simulation for maximum cultural authenticity.",
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= INFO CARD =================

  Widget infoCard(
    IconData icon,
    String title,
    String description,
  ) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),

        borderRadius:
            BorderRadius.circular(25),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              CircleAvatar(
                backgroundColor: Colors.amber,

                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                title,

                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            description,

            style: const TextStyle(
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}