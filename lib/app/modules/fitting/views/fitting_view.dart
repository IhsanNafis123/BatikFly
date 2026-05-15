import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../controllers/fitting_controller.dart';

class FittingView extends GetView<FittingController> {
  const FittingView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF0F1021);
    const Color surfaceColor = Color(0xFF1A1B35);
    const Color accentGold = Color(0xFFEAC349);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        title: const Text('STYLO FITTING ROOM', 
          style: TextStyle(color: accentGold, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PREVIEW 3D & MOTIF
            Stack(
              children: [
                Container(
                  height: 380,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator(color: accentGold));
                    }
                    if (controller.generatedModel3DUrl.value.isEmpty) {
                      return const Center(child: Text("Klik GENERATE 3D", style: TextStyle(color: Colors.white54)));
                    }
                    return ModelViewer(
                      src: controller.generatedModel3DUrl.value,
                      autoRotate: true,
                      cameraControls: true,
                      backgroundColor: Colors.transparent,
                    );
                  }),
                ),
                // Gambar Cuplikan Batik di Pojok
                Positioned(
                  top: 35,
                  right: 35,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: accentGold, width: 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/logo.jpeg'), // Gambar Batikmu
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // PANEL INPUT
            Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kustomisasi Pesanan", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),

                  // Pilih Ukuran & Lengan
                  Row(
                    children: [
                      _buildSizeDropdown(accentGold),
                      const SizedBox(width: 20),
                      _buildSleeveToggle(accentGold),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // HASIL ESTIMASI
                  _buildResultCard(accentGold),

                  const SizedBox(height: 30),

                  // TOMBOL GENERATE
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => controller.processGeneration(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentGold,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("TAMPILKAN 3D", 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(surfaceColor, accentGold),
    );
  }

  Widget _buildSizeDropdown(Color gold) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ukuran Baju", style: TextStyle(color: Colors.white70, fontSize: 12)),
          Obx(() => DropdownButton<String>(
            value: controller.selectedSize.value,
            dropdownColor: const Color(0xFF1A1B35),
            isExpanded: true,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            underline: Container(height: 2, color: gold),
            items: ['S', 'M', 'L', 'XL', 'XXL'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (val) {
              controller.selectedSize.value = val!;
              controller.updateFabricRequirement();
            },
          )),
        ],
      ),
    );
  }

  Widget _buildSleeveToggle(Color gold) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Model Lengan", style: TextStyle(color: Colors.white70, fontSize: 12)),
          Obx(() => Row(
            children: [
              const Text("Pendek", style: TextStyle(color: Colors.white, fontSize: 11)),
              Switch(
                value: controller.isLongSleeve.value,
                activeColor: gold,
                onChanged: (val) {
                  controller.isLongSleeve.value = val;
                  controller.updateFabricRequirement();
                },
              ),
              const Text("Panjang", style: TextStyle(color: Colors.white, fontSize: 11)),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildResultCard(Color gold) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: gold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Butuh Kain:", style: TextStyle(color: Colors.white70)),
              Text("${controller.fabricResult.value} Meter", 
                style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          const Divider(color: Colors.white10, height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: Colors.white70, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text("Bahan Bagus: ${controller.recommendedMaterial.value}", 
                  style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildNavBar(Color bg, Color gold) {
    return BottomNavigationBar(
      backgroundColor: bg,
      selectedItemColor: gold,
      unselectedItemColor: Colors.grey,
      currentIndex: 2,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
        BottomNavigationBarItem(icon: Icon(Icons.design_services), label: "Desain"),
        BottomNavigationBarItem(icon: Icon(Icons.accessibility_new), label: "Fitting"),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "Artikel"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
    );
  }
}