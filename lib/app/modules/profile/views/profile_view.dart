// ================= PROFILE VIEW =================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

import '../../navbar/controllers/navbar_controller.dart';
import '../../navbar/views/navbar_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView
    extends GetView<ProfileController> {

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    final navbarController =
        Get.find<NavbarController>();

    navbarController.changePage(4);

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

        bottomNavigationBar:
            const NavbarView(),

        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              children: [

                // ================= HEADER =================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

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

                    IconButton(
                      onPressed: () {

                        Get.toNamed(
                          Routes.SETTING,
                        );
                      },

                      icon: const Icon(
                        Icons.settings,
                        color: Colors.amber,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // ================= FOTO PROFIL =================

                Obx(
                  () => CircleAvatar(
                    radius: 55,

                    backgroundColor:
                        Colors.amber,

                    backgroundImage:
                        AssetImage(
                      controller
                          .profileImage
                          .value,
                    ),
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

                    style:
                        const TextStyle(
                      color:
                          Colors.white,

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

                    style:
                        const TextStyle(
                      color:
                          Colors.white70,

                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // ================= EDIT BUTTON =================

                SizedBox(
                  width: 180,
                  height: 45,

                  child:
                      ElevatedButton.icon(
                    onPressed:
                        controller
                            .editProfile,

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          Colors.amber,

                      foregroundColor:
                          Colors.black,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),
                    ),

                    icon: const Icon(
                      Icons.edit,
                    ),

                    label: const Text(
                      "EDIT PROFIL",

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
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

                    "Galeri Favorit",

                    "${controller.totalGallery.value} Desain Favorit",
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                Obx(
                  () => profileCard(
                    Icons.palette,

                    "Style Favorit",

                    controller
                        .favoriteStyle
                        .value,
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                // ================= LOGOUT =================

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

      padding:
          const EdgeInsets.all(18),

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

          const SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  title,

                  style:
                      const TextStyle(
                    color:
                        Colors.white,

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  subtitle,

                  style:
                      const TextStyle(
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