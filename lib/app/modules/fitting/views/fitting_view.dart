import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../controllers/fitting_controller.dart';

class FittingView extends GetView<FittingController> {
  const FittingView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF0F1021);
    const Color surfaceColor = Color(0xFF15192F);
    const Color accentGold = Colors.amber;

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        title: const Text(
          'FITTING ROOM',
          style: TextStyle(
            color: accentGold,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ================= AREA PREVIEW 3D & VTON =================
            Stack(
              children: [
                Container(
                  height: 380,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Obx(() {
                    // 1. Jika Sedang Loading
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: accentGold),
                      );
                    }

                    // 2. Jika ada hasil VTON (Try-On 2D di foto user)
                    if (controller.generatedVisualUrl.value.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          controller.generatedVisualUrl.value,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }

                    // 3. Jika belum ada model 3D maupun VTON
                    if (controller.generatedModel3DUrl.value.isEmpty) {
                      return const Center(
                        child: Text(
                          "Pilih motif lalu klik TAMPILKAN 3D\natau COBA DI FOTO SAYA",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }

                    // 4. Tampilkan Model 3D Kemeja
                    return ModelViewer(
                      src: controller.generatedModel3DUrl.value,
                      alt: "3D Batik Model",
                      autoRotate: true,
                      cameraControls: true,
                      backgroundColor: Colors.transparent,
                      shadowIntensity: 1,
                      exposure: 1,
                      // BARIS INI YANG DITAMBAHKAN:
                      // Memicu fungsi inject JS ketika WebView 3D siap
                      onWebViewCreated: (controllerWebView) {
                        controller.injectMotifKe3D(controllerWebView);
                      },
                    );
                  }),
                ),
                // Overlay Gambar Motif Batik (logo.jpeg)
                Positioned(
                  top: 25,
                  right: 35,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accentGold, width: 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ================= PANEL KONTROL & UKURAN =================
            Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // TOMBOL PILIH MOTIF DARI GALERI
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.pickMotifImage(),
                      icon: const Icon(Icons.image, color: Colors.white),
                      label: Obx(() => Text(
                        controller.selectedMotif.value == null 
                          ? "Pilih Motif dari Galeri" 
                          : "Motif Terpilih! (Siap Diproses)",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white10,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  const Text(
                    "Konfigurasi Ukuran",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      // Dropdown Ukuran
                      _buildSizeDropdown(accentGold),
                      const SizedBox(width: 20),
                      // Toggle Lengan
                      _buildSleeveToggle(accentGold),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Hasil Estimasi Bahan
                  _buildResultCard(accentGold),

                  const SizedBox(height: 30),

                  // ================= TOMBOL AKSI =================
                  // 1. TOMBOL UTAMA TAMPILKAN 3D
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => controller.processGeneration(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentGold,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "TAMPILKAN 3D",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),

                  // 2. TOMBOL SUB-FITUR VTON (COBA DI FOTO SAYA)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      // Memanggil fungsi baru di controller
                      onPressed: () => controller.tryOnFotoSendiri(), 
                      icon: const Icon(Icons.camera_alt, color: accentGold),
                      label: const Text(
                        "COBA DI FOTO SAYA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: accentGold,
                        side: const BorderSide(color: accentGold, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAVIGATION BAR =================
    );
  }

  // Widget Helper: Dropdown Ukuran
  Widget _buildSizeDropdown(Color gold) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pilih Ukuran",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Obx(
            () => DropdownButton<String>(
              value: controller.selectedSize.value,
              dropdownColor: const Color(0xFF1A1B35),
              isExpanded: true,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              underline: Container(height: 2, color: gold),
              items: ['S', 'M', 'L', 'XL', 'XXL'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) {
                controller.selectedSize.value = val!;
                controller.updateFabricRequirement();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper: Toggle Lengan
  Widget _buildSleeveToggle(Color gold) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tipe Lengan",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Obx(
            () => Row(
              children: [
                Text(
                  controller.isLongSleeve.value ? "Panjang" : "Pendek",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: controller.isLongSleeve.value,
                  activeThumbColor: gold,
                  onChanged: (val) {
                    controller.isLongSleeve.value = val;
                    controller.updateFabricRequirement();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper: Kartu Hasil Kalkulasi
  Widget _buildResultCard(Color gold) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: gold.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: gold.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kebutuhan Bahan:",
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  "${controller.fabricResult.value} Meter",
                  style: TextStyle(
                    color: gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.tips_and_updates,
                  color: Colors.amber,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Rekomendasi: ${controller.recommendedMaterial.value}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}