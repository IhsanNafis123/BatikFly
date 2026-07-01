import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  // TEMA WARNA BATIKFLY (Sama dengan HomeView)
  static const Color bgDark = Color(0xFF0D0F1A);
  static const Color cardColor = Color(0xFF1A1F3A);
  static const Color accentGold = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: bgDark,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: accentGold),
            );
          }

          return RefreshIndicator(
            color: accentGold,
            backgroundColor: cardColor,
            onRefresh: controller.getProfile,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  backgroundColor: bgDark,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF252D52), // Biru gelap elegan
                            Color(0xFF1B2240),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: "profile",
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: accentGold.withValues(alpha: 0.5),
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: cardColor,
                                  backgroundImage:
                                      controller.avatar.value.isNotEmpty
                                      ? NetworkImage(controller.avatar.value)
                                      : null,
                                  child: controller.avatar.value.isEmpty
                                      ? const Icon(
                                          Icons.person,
                                          size: 55,
                                          color: accentGold,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              controller.username.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.email.value,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final result = await Get.toNamed(
                                  Routes.EDIT_PROFILE,
                                );
                                if (result == true) {
                                  controller.getProfile();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentGold,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              icon: const Icon(Icons.edit, size: 18),
                              label: const Text(
                                "Edit Profil",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informasi Akun",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _buildInfoCard(
                          icon: Icons.person,
                          title: "Username",
                          value: controller.username.value,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoCard(
                          icon: Icons.email_outlined,
                          title: "Email",
                          value: controller.email.value,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoCard(
                          icon: Icons.calendar_month_outlined,
                          title: "Tanggal Bergabung",
                          value: controller.joinDate.value,
                        ),
                        const SizedBox(height: 35),

                        const Text(
                          "Statistik Pengguna",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _buildStatisticCard(
                                title: "Design",
                                value: controller.totalDesign.value.toString(),
                                color: Colors
                                    .blueAccent, // Warna terang cocok untuk mode gelap
                                icon: Icons.palette,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatisticCard(
                                title: "Fitting",
                                value: controller.totalFitting.value.toString(),
                                color: Colors.orangeAccent,
                                icon: Icons.checkroom,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatisticCard(
                                title: "Download",
                                value: controller.totalDownload.value
                                    .toString(),
                                color: Colors.greenAccent,
                                icon: Icons.download,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),

                        const Text(
                          "Lainnya",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _buildMenuCard(
                          icon: Icons.history,
                          title: "Log Activity",
                          subtitle: "Lihat seluruh aktivitas akun",
                          onTap: () {
                            Get.toNamed(Routes.LOG_ACTIVITY);
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildMenuCard(
                          icon: Icons.info_outline,
                          title: "Tentang Aplikasi",
                          subtitle: "Informasi mengenai BatikFly",
                          onTap: () {
                            Get.toNamed(Routes.ABOUT_APP);
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildMenuCard(
                          icon: Icons.privacy_tip_outlined,
                          title: "Kebijakan Privasi",
                          subtitle: "Lihat kebijakan penggunaan aplikasi",
                          onTap: () {
                            Get.toNamed(Routes.PRIVACY_POLICY);
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildMenuCard(
                          icon: Icons.settings,
                          title: "Pengaturan",
                          subtitle: "Kelola pengaturan aplikasi",
                          onTap: () {
                            Get.toNamed(Routes.SETTING);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ==============================================================
  // WIDGET BANTUAN (Telah disesuaikan dengan Dark Mode)
  // ==============================================================

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12), // Border tipis transparan
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: accentGold.withValues(alpha: 0.15),
            child: Icon(icon, color: accentGold),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: accentGold.withValues(alpha: 0.15),
              child: Icon(icon, color: accentGold),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}
