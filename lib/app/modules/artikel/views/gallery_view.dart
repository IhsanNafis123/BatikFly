import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_controller.dart';
import 'gallery_detail_view.dart';

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
          'REFERENSI DESAIN',
          style: TextStyle(
            color: accentGold,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: accentGold),
          );
        }

        if (controller.articles.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada desain yang dibagikan.",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
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
                  // Gambar Desain Batik
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white54,
                                size: 50,
                              ),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.motifName,
                          style: const TextStyle(
                            color: accentGold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Bagian Nama Kreator & Avatar
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.grey.shade800,
                              backgroundImage: article.creatorAvatar != null
                                  ? NetworkImage(article.creatorAvatar!)
                                  : null,
                              child: article.creatorAvatar == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.white54,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              article.creatorName,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Text(
                          "Filosofi: ${article.philosophy}",
                          style: const TextStyle(
                            color: accentGold,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              () => const GalleryDetailView(),
                              arguments: article,
                              transition: Transition.rightToLeft,
                            );
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            "LIHAT DETAIL",
                            style: TextStyle(
                              color: accentGold,
                              fontWeight: FontWeight.bold,
                            ),
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
    );
  }
}
