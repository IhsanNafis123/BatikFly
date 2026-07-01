import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D0F1A), Color(0xFF1A1F3A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🧵 Batik Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset("assets/batik_pattern.png", fit: BoxFit.cover),
            ),
          ),

          // 🔥 Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // ===== LOGO APLIKASI =====
                      Image.asset(
                        "assets/logo dalam.png",
                        height:
                            200, // Silakan ubah jika logo kurang besar/kecil
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // ===== FORM LOGIN MANUAL =====
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: controller.emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.amber,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.amber,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: controller.passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.amber,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.amber,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : () => controller.login(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : const Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== TOMBOL LOGIN GOOGLE =====
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () => controller.loginWithGoogle(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(
                            Icons.g_mobiledata,
                            color: Colors.white,
                            size: 35,
                          ),
                          label: const Text(
                            "Continue with Google",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== PINDAH KE REGISTER =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
