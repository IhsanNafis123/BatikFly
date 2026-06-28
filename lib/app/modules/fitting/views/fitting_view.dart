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
                    if (controller.isLoading.value)
                      return const Center(
                        child: CircularProgressIndicator(color: accentGold),
                      );
                    if (controller.generatedVisualUrl.value.isNotEmpty)
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          controller.generatedVisualUrl.value,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      );
                    if (controller.generatedModel3DUrl.value.isEmpty)
                      return const Center(
                        child: Text(
                          "Pilih motif lalu klik TAMPILKAN 3D\natau COBA DI FOTO SAYA",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    return ModelViewer(
                      src: controller.generatedModel3DUrl.value,
                      alt: "3D Batik Model",
                      autoRotate: true,
                      cameraControls: true,
                      backgroundColor: Colors.transparent,
                      shadowIntensity: 1,
                      exposure: 1,
                      onWebViewCreated: (controllerWebView) =>
                          controller.injectMotifKe3D(controllerWebView),
                    );
                  }),
                ),
                Positioned(
                  top: 25,
                  right: 35,
                  child: Obx(() {
                    Widget previewWidget;
                    if (controller.selectedMotif.value != null)
                      previewWidget = Image.file(
                        controller.selectedMotif.value!,
                        fit: BoxFit.cover,
                      );
                    else if (controller.selectedCustomMotifUrl.value.isNotEmpty)
                      previewWidget = Image.network(
                        controller.selectedCustomMotifUrl.value,
                        fit: BoxFit.cover,
                      );
                    else
                      previewWidget = Image.asset(
                        'assets/logo.jpeg',
                        fit: BoxFit.cover,
                      );

                    return Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentGold, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: previewWidget,
                    );
                  }),
                ),
              ],
            ),
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => controller.pickMotifImage(),
                          icon: const Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            "Dari Galeri",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white10,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              controller.showSupabaseDesignPicker(),
                          icon: const Icon(
                            Icons.brush,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            "Desain Saya",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentGold.withValues(alpha: 0.2),
                            foregroundColor: accentGold,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(color: accentGold, width: 1),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Pilih Model 3D",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _buildModelCard(
                        title: "Kaos",
                        icon: Icons.checkroom,
                        model: "assets/models/tshirt.glb",
                      ),
                      _buildModelCard(
                        title: "Kemeja Pendek",
                        icon: Icons.dry_cleaning,
                        model: "assets/models/shirt_short.glb",
                      ),
                      _buildModelCard(
                        title: "Kemeja Panjang",
                        icon: Icons.accessibility_new,
                        model: "assets/models/shirt_long.glb",
                      ),
                      _buildModelCard(
                        title: "Blouse",
                        icon: Icons.local_mall,
                        model: "assets/models/blouse.glb",
                      ),
                    ],
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
                      _buildSizeDropdown(accentGold),
                      const SizedBox(width: 20),
                      _buildSleeveToggle(accentGold),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildResultCard(accentGold),
                  const SizedBox(height: 30),
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
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              items: ['S', 'M', 'L', 'XL', 'XXL']
                  .map(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
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

  Widget _buildModelCard({
    required String title,
    required IconData icon,
    required String model,
  }) {
    return Obx(() {
      final selected = controller.selectedModel.value == model;
      return GestureDetector(
        onTap: () => controller.selectedModel.value = model,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: selected
                ? Colors.amber.withValues(alpha: 0.15)
                : const Color(0xFF1A1B35),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? Colors.amber : Colors.white12,
              width: 2,
            ),
            boxShadow: [
              if (selected)
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 42,
                color: selected ? Colors.amber : Colors.white54,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.amber : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
