import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/desain_controller.dart';

class DesainView extends StatelessWidget {
  DesainView({super.key});

  final controller = Get.put(DesainController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        statusBarIconBrightness: Brightness.light,
      ),

      child: Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ================= HEADER =================
                Row(
                  children: [
                    Image.asset("assets/logo dalam.png", width: 35),

                    const SizedBox(width: 10),

                    const Text(
                      "BatikFly",

                      style: TextStyle(
                        color: Colors.amber,

                        fontSize: 22,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "Weave Your Vision",

                  style: TextStyle(
                    color: Colors.amber,

                    fontSize: 34,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= MODE =================
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          activeColor: Colors.amber,

                          value: "prompt",

                          groupValue: controller.selectedMode.value,

                          onChanged: (v) {
                            controller.selectedMode.value = v!;
                          },

                          title: const Text(
                            "Prompt",

                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      Expanded(
                        child: RadioListTile(
                          activeColor: Colors.amber,

                          value: "hybrid",

                          groupValue: controller.selectedMode.value,

                          onChanged: (v) {
                            controller.selectedMode.value = v!;
                          },

                          title: const Text(
                            "Hybrid",

                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                Obx(
                  () => Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1F3A),

                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Text(
                      controller.selectedMode.value == "prompt"
                          ? "Prompt Only Mode : AI membuat motif batik dari deskripsi pengguna"
                          : "Hybrid Mode : Dataset Batik + Computer Vision + AI",

                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // ================= DROPDOWN =================
                Obx(() {
                  if (controller.selectedMode.value != "hybrid") {
                    return const SizedBox();
                  }

                  return DropdownButtonFormField(
                    value: controller.selectedMotif.value,

                    dropdownColor: const Color(0xFF1A1F3A),

                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      filled: true,

                      fillColor: const Color(0xFF1A1F3A),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    items: controller.motifList.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),

                    onChanged: (v) {
                      controller.selectedMotif.value = v!;
                    },
                  );
                }),

                const SizedBox(height: 20),

                // ================= INPUT =================
                Container(
                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F3A),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: TextField(
                    controller: controller.promptController,

                    maxLines: 4,

                    style: const TextStyle(color: Colors.white),

                    decoration: const InputDecoration(
                      border: InputBorder.none,

                      hintText: "e.g. Modern Mega Mendung blue gold",

                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= BUTTON =================
                SizedBox(
                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,

                      foregroundColor: Colors.black,
                    ),

                    onPressed: () {
                      controller.generateMotif();
                    },

                    icon: Obx(() {
                      if (controller.isLoading.value) {
                        return const SizedBox(
                          width: 20,
                          height: 20,

                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }

                      return const Icon(Icons.auto_awesome);
                    }),

                    label: Obx(() {
                      return Text(
                        controller.isLoading.value
                            ? "Generating..."
                            : "GENERATE MOTIF",

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                // ================= RESULT =================
                Obx(() {
                  if (controller.generatedImage.value.isEmpty) {
                    return const SizedBox();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),

                            child: Image.network(
                              controller.generatedImage.value,

                              width: double.infinity,

                              height: width * 0.8,

                              fit: BoxFit.cover,

                              loadingBuilder: (context, child, progress) {
                                if (progress == null) {
                                  return child;
                                }

                                return SizedBox(
                                  height: width * 0.8,

                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.amber,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,

                            child: ElevatedButton.icon(
                              onPressed: () {
                                controller.saveDesign();
                              },

                              icon: const Icon(Icons.save),

                              label: const Text("SAVE MOTIF"),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      infoCard(
                        Icons.menu_book,

                        "Philosophy",

                        controller.philosophy.value,
                      ),

                      const SizedBox(height: 20),

                      infoCard(
                        Icons.graphic_eq,

                        "AI Weave Density",

                        controller.density.value,
                      ),

                      const SizedBox(height: 20),

                      Obx(() {
                        if (controller.motifName.value.isEmpty) {
                          return const SizedBox();
                        }

                        return infoCard(
                          Icons.palette,

                          "Base Motif",

                          controller.motifName.value,
                        );
                      }),

                      const SizedBox(height: 20),

                      Obx(() {
                        if (controller.modeResult.value.isEmpty) {
                          return const SizedBox();
                        }

                        return infoCard(
                          Icons.settings,

                          "Generation Mode",

                          controller.modeResult.value,
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= CARD =================

  Widget infoCard(IconData icon, String title, String description) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),

        borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.amber,

                child: Icon(icon, color: Colors.black),
              ),

              const SizedBox(width: 10),

              Text(
                title,

                style: const TextStyle(
                  color: Colors.amber,

                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            description,

            style: const TextStyle(color: Colors.white70, height: 1.6),
          ),
        ],
      ),
    );
  }
}
