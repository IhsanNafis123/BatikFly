import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D0F1A),
                  Color(0xFF1A1F3A),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Batik Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                "assets/batik_pattern.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo dalam.png",
                        height: 180,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Masukkan token reset yang dikirim ke email Anda, kemudian buat password baru.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white12,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Token Reset
                            TextField(
                              controller: controller.tokenController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelText: "Token Reset",
                                labelStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.vpn_key,
                                  color: Colors.amber,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Password Baru
                            TextField(
                              controller:
                                  controller.passwordController,
                              obscureText: true,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password Baru",
                                labelStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.amber,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Konfirmasi Password
                            TextField(
                              controller: controller
                                  .confirmPasswordController,
                              obscureText: true,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelText: "Konfirmasi Password",
                                labelStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.amber,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller
                                          .isLoading.value
                                      ? null
                                      : controller.resetPassword,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                              10),
                                    ),
                                  ),
                                  child: controller
                                          .isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : const Text(
                                          "SIMPAN PASSWORD",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "Kembali ke Login",
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}