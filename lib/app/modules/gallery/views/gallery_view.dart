import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/gallery_controller.dart';
import 'gallery_detail_view.dart'; // Import halaman detail

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF111317);
    const Color accentGold = Color(0xFFEAC349);
    const Color surfaceColor = Color(0xFF1A1B35);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ARTIKEL FILOSOFI',
          style: TextStyle(
            color: accentGold, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 1.5
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: controller.articles.length,
        itemBuilder: (context, index) {
          final article = controller.articles[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accentGold.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Cuplikan
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.asset(article.imagePath, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          color: accentGold, 
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Filosofi: ${article.philosophy}",
                        style: const TextStyle(
                          color: accentGold, 
                          fontSize: 13, 
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        article.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70, 
                          fontSize: 14, 
                          height: 1.5
                        ),
                      ),
                      const SizedBox(height: 12),
                      // TOMBOL NAVIGASI KE DETAIL
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () => const GalleryDetailView(),
                            arguments: article, // Kirim data ke halaman detail
                            transition: Transition.rightToLeft,
                          );
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text(
                          "BACA SELENGKAPNYA", 
                          style: TextStyle(
                            color: accentGold, 
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      
      // ================= BOTTOM NAVBAR =================
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF15192F),
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            
            // Cegah reload jika menekan tab halaman saat ini (Artikel / Gallery)
            if (index == 3) return;

            controller.selectedIndex.value = index;

            // Navigasi menggunakan switch-case agar lebih rapi
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME);
                break;
              case 1:
                Get.offAllNamed(Routes.DESAIN);
                break;
              case 2:
                Get.offAllNamed(Routes.FITTING);
                break;
              case 4:
                Get.offAllNamed(Routes.PROFILE);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.brush), label: 'Desain'),
            BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Fitting'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Artikel'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}