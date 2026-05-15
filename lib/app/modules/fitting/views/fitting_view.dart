import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/fitting_controller.dart';

class FittingView extends GetView<FittingController> {
  const FittingView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF111317);
    const Color surfaceColor = Color(0xFF1A1B35);
    const Color accentGold = Color(0xFFEAC349);
    const Color onSurface = Color(0xFFE2E2E7);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'FITTING ROOM 3D',
          style: TextStyle(color: accentGold, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN 1: MOTIF (DENGAN EFEK MEREDUP) ---
            _buildSectionTitle("Motif Batik Custom", onSurface),
            const SizedBox(height: 12),
            _buildMotifList(controller.customMotifs, accentGold),

            const SizedBox(height: 30),

            // --- BAGIAN 2: MODEL (DENGAN EFEK MEREDUP) ---
            _buildSectionTitle("Pilih Model Lengan", onSurface),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildModelTypeCard("Pendek", Icons.short_text, accentGold),
                const SizedBox(width: 15),
                _buildModelTypeCard("Panjang", Icons.notes, accentGold),
              ],
            ),

            const SizedBox(height: 35),

            // --- BAGIAN 3: PREVIEW & TOMBOL BUAT ---
            _buildSectionTitle("Preview Model 3D", onSurface),
            const SizedBox(height: 12),
            Obx(() {
              final currentMotif = controller.selectedMotifPath.value;
              final currentModel = controller.selectedModelType.value;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: accentGold.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          currentModel == "Pendek" ? Icons.dry_cleaning : Icons.checkroom, 
                          size: 180, 
                          color: Colors.white.withValues(alpha: 0.05)
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentMotif, width: 80, height: 80, fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // TOMBOL BUAT MODEL
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentGold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () => controller.processCreateModel(),
                        child: const Text(
                          "BUAT MODEL 3D", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(accentGold),
    );
  }

  // WIDGET HELPERS

  Widget _buildSectionTitle(String title, Color color) {
    return Text(title, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildMotifList(List<String> items, Color activeColor) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final path = items[index];
          return Obx(() {
            bool isSelected = controller.selectedMotifPath.value == path;
            return GestureDetector(
              onTap: () => controller.selectMotif(path),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSelected ? 1.0 : 0.3, // MEREDUP JIKA TIDAK DIPILIH
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isSelected ? activeColor : Colors.white10, width: 2),
                    image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildModelTypeCard(String type, IconData icon, Color gold) {
    return Expanded(
      child: Obx(() {
        bool isSelected = controller.selectedModelType.value == type;
        return GestureDetector(
          onTap: () => controller.selectModel(type),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1.0 : 0.3, // MEREDUP JIKA TIDAK DIPILIH
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isSelected ? gold.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isSelected ? gold : Colors.white12),
              ),
              child: Column(
                children: [
                  Icon(icon, color: isSelected ? gold : Colors.white54, size: 30),
                  const SizedBox(height: 8),
                  Text("Lengan $type", style: TextStyle(color: isSelected ? gold : Colors.white54)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomNav(Color gold) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: (index) {
        controller.selectedIndex.value = index;
        if (index == 0) Get.offAllNamed(Routes.HOME);
        else if (index == 1) Get.offAllNamed(Routes.DESAIN);
        else if (index == 3) Get.offAllNamed(Routes.GALLERY);
        else if (index == 4) Get.offAllNamed(Routes.PROFILE);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF15192F),
      selectedItemColor: gold,
      unselectedItemColor: Colors.white70,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.brush), label: 'Desain'),
        BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Fitting 3D'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Artikel'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    ));
  }
}