import 'package:get/get.dart';

// Model sederhana untuk Artikel
class BatikArticle {
  final String title;
  final String imagePath;
  final String philosophy;
  final String content;

  BatikArticle({
    required this.title,
    required this.imagePath,
    required this.philosophy,
    required this.content,
  });
}

class GalleryController extends GetxController {
  var selectedIndex = 3.obs; // Index menu ke-4

  // Data Artikel Batik
  final List<BatikArticle> articles = [
    BatikArticle(
      title: "Parang Kencana Custom",
      imagePath: "assets/logo.jpeg", // Gunakan aset yang tersedia dulu
      philosophy: "Kesinambungan & Perjuangan",
      content: "Motif Parang yang Anda buat memiliki alur diagonal yang melambangkan jalinan yang tidak pernah putus. Dalam filosofi Jawa, ini berarti perjuangan manusia untuk terus memperbaiki diri dan mencapai kesejahteraan tanpa henti.",
    ),
    BatikArticle(
      title: "Mega Mendung Modern",
      imagePath: "assets/logo.jpeg",
      philosophy: "Kesabaran & Ketenangan",
      content: "Motif awan ini mencerminkan dunia atas yang bebas. Filosofinya mengajarkan kita untuk selalu berkepala dingin, sabar, dan tenang dalam menghadapi segala situasi kehidupan yang penuh tantangan.",
    ),
  ];
}