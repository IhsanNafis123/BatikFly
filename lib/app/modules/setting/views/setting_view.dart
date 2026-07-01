import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF0F1021);
    const Color surfaceColor = Color(0xFF15192F);
    const Color accentGold = Colors.amber;

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        title: const Text(
          "PENGATURAN",
          style: TextStyle(
            color: accentGold,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                leading: const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0x33FFC107),
                  child: Icon(
                    Icons.logout_rounded,
                    color: accentGold,
                    size: 26,
                  ),
                ),
                title: const Text(
                  "Keluar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text(
                  "Keluar dari akun BatikFly",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 18,
                ),
                onTap: controller.showLogoutDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}