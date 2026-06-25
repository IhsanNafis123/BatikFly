import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
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

        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [

                    // HEADER

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
                                    FontWeight
                                        .bold,
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
                            color:
                                Colors.amber,
                            size: 30,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // FOTO PROFIL

                    Obx(
                      () => CircleAvatar(
                        radius: 55,
                        backgroundColor:
                            Colors.amber,

                        backgroundImage:
                            controller
                                    .avatar
                                    .value
                                    .isNotEmpty
                                ? NetworkImage(
                                    controller
                                        .avatar
                                        .value,
                                  )
                                : null,

                        child: controller
                                .avatar
                                .value
                                .isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 55,
                                color:
                                    Colors.black,
                              )
                            : null,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // NAMA

                    Obx(
                      () => Text(
                        controller
                            .name.value,
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 28,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // EMAIL

                    Obx(
                      () => Text(
                        controller
                            .email.value,
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // PROVIDER

                    Obx(
                      () => profileCard(
                        Icons.login,
                        "Login Provider",
                        controller
                            .provider
                            .value,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    // USER ID

                    Obx(
                      () => profileCard(
                        Icons.badge,
                        "Nama Pengguna",
                        controller
                            .name
                            .value,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Obx(
                      () => profileCard(
                        Icons.email,
                        "Email",
                        controller
                            .email
                            .value,
                      ),
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    // LOGOUT

                    SizedBox(
                      width:
                          double.infinity,
                      height: 55,
                      child:
                          ElevatedButton
                              .icon(
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
                            controller
                                .logout,
                        icon: const Icon(
                          Icons.logout,
                        ),
                        label: const Text(
                          "LOGOUT",
                          style:
                              TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

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