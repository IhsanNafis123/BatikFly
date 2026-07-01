import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../navbar/controllers/navbar_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil NavbarController untuk fitur pindah halaman dari Beranda
    final navbarController = Get.find<NavbarController>();

    // Tema Warna BatikFly
    const Color bgDark = Color(0xFF0D0F1A);
    const Color cardColor = Color(0xFF1A1F3A);
    const Color accentGold = Colors.amber;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: bgDark,
        body: SafeArea(
          child: RefreshIndicator(
            color: accentGold,
            backgroundColor: cardColor,
            onRefresh: () async {
              try {
                await controller.fetchHomeTrends();
              } catch (e) {
                debugPrint("Error refresh: $e");
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= 1. HEADER & PROFIL =================
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/logo dalam.png",
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "BatikFly",
                                  style: TextStyle(
                                    color: accentGold,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () =>
                              navbarController.changeIndex(4), // Ke Profile
                          child: Obx(() {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: cardColor,
                              backgroundImage:
                                  controller.userAvatar.value.isNotEmpty
                                  ? NetworkImage(controller.userAvatar.value)
                                  : null,
                              child: controller.userAvatar.value.isEmpty
                                  ? const Icon(Icons.person, color: accentGold)
                                  : null,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  // ================= 2. GREETING & AI PROMPT BAR =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Siap berkreasi hari ini?",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () =>
                              navbarController.changeIndex(1), // Ke Desain
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.auto_awesome,
                                  color: accentGold,
                                ),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Text(
                                    "Ketik prompt batik impianmu...",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: accentGold,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= 3. BANNER FITTING 3D =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF252D52), Color(0xFF1B2240)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Virtual Fitting",
                                  style: TextStyle(
                                    color: accentGold,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Coba desain batik buatanmu langsung ke model 3D.",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accentGold,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () => navbarController.changeIndex(
                                    2,
                                  ), // Ke Fitting
                                  icon: const Icon(Icons.camera_alt, size: 18),
                                  label: const Text(
                                    "Coba Sekarang",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.checkroom,
                            color: Colors.white10,
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= 4. TREN VIRAL TIKTOK =================
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.redAccent,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Sedang Viral di TikTok",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 90,
                    child: Obx(() {
                      if (controller.tiktokViral.isEmpty) {
                        return const Center(
                          child: Text(
                            "Memuat data TikTok...",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: controller.tiktokViral.length,
                        itemBuilder: (context, index) {
                          final item = controller.tiktokViral[index];
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF252D52), cardColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: accentGold.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['motif'] ?? 'Motif',
                                  style: const TextStyle(
                                    color: accentGold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['views'] ?? '0 Views',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 30),

                  // ================= 5. TREN MOTIF (TOP 5) =================
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "📈 Top 5 Motif Terpopuler",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 45,
                    child: Obx(() {
                      if (controller.trendingMotifs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Memuat tren...",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: controller.trendingMotifs.length,
                        itemBuilder: (context, index) {
                          final motif = controller.trendingMotifs[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cardColor,
                              border: Border.all(
                                color: accentGold.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "#${index + 1}",
                                  style: const TextStyle(
                                    color: accentGold,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  motif['name'] ?? 'Motif',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

                  // ================= 6. TREN KOMUNITAS =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "✨ Inspirasi Komunitas",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () =>
                              navbarController.changeIndex(3), // Ke Galeri
                          child: const Text(
                            "Lihat Semua",
                            style: TextStyle(color: accentGold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  Obx(() {
                    if (controller.communityTrends.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(color: accentGold),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: controller.communityTrends.length,
                      itemBuilder: (context, index) {
                        final item = controller.communityTrends[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                ),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child:
                                      (item['image'] != null &&
                                          item['image'] != '')
                                      ? Image.network(
                                          item['image'],
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, e, s) =>
                                              Image.asset(
                                                "assets/batik_pattern.png",
                                                fit: BoxFit.cover,
                                              ),
                                        )
                                      : Image.asset(
                                          "assets/batik_pattern.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] ?? 'Batik AI',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Colors.white54,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              item['creator'] ?? 'Anonim',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                      size: 22,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['likes'] ?? '0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),

                  const SizedBox(height: 30),

                  // ================= 7. ARTIKEL BATIK TERBARU =================
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "📚 Artikel & Filosofi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 190,
                    child: Obx(() {
                      if (controller.latestArticles.isEmpty) {
                        return const Center(
                          child: Text(
                            "Belum ada artikel.",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: controller.latestArticles.length,
                        itemBuilder: (context, index) {
                          final article = controller.latestArticles[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigasi ke detail artikel
                            },
                            child: Container(
                              width: 220,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child:
                                          (article['image_url'] != null &&
                                              article['image_url'] != '')
                                          ? Image.network(
                                              article['image_url'],
                                              fit: BoxFit.cover,
                                              errorBuilder: (c, e, s) =>
                                                  Image.asset(
                                                    "assets/batik_pattern.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                            )
                                          : Image.asset(
                                              "assets/batik_pattern.png",
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
                                          article['title'] ?? 'Judul Artikel',
                                          style: const TextStyle(
                                            color: accentGold,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          article['philosophy'] ??
                                              'Membahas filosofi batik...',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
