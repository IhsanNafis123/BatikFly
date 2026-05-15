import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_controller.dart';

class GalleryDetailView extends StatelessWidget {
  const GalleryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data yang dikirim via arguments
    final BatikArticle article = Get.arguments;

    const Color bgDark = Color(0xFF111317);
    const Color accentGold = Color(0xFFEAC349);
    const Color surfaceColor = Color(0xFF1A1B35);

    return Scaffold(
      backgroundColor: bgDark,
      body: CustomScrollView(
        slivers: [
          // AppBar yang bisa mengecil saat di-scroll
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: surfaceColor,
            leading: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: accentGold),
                onPressed: () => Get.back(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                article.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Konten Artikel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: accentGold, 
                      fontSize: 28, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif'
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: accentGold.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: accentGold, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Filosofi: ${article.philosophy}",
                            style: const TextStyle(
                              color: accentGold, 
                              fontStyle: FontStyle.italic,
                              fontSize: 15
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Tentang Motif Ini",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    article.content,
                    style: const TextStyle(
                      color: Colors.white70, 
                      fontSize: 16, 
                      height: 1.8, // Spasi baris agar nyaman dibaca
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}