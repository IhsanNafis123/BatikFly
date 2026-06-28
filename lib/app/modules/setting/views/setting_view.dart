import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff8B4513),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xffFDECEC),
                  child: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                ),

                title: const Text(
                  "Keluar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Keluar dari akun BatikFly",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
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