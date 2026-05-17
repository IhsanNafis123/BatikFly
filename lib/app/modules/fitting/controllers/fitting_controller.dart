import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FittingController extends GetxController {
  var isLoading = false.obs;
  var generatedModel3DUrl = "".obs;
  var selectedIndex = 2.obs;

  // State untuk Input User
  var selectedSize = "M".obs;       // Default M
  var isLongSleeve = false.obs;     // Default Lengan Pendek
  var fabricResult = "1.50".obs;    // Hasil perhitungan meter
  var recommendedMaterial = "Katun Primisima".obs; // Rekomendasi bahan

  // Tabel Data Ukuran (Sesuai permintaanmu)
  final Map<String, Map<String, String>> sizeData = {
    'S': {'pendek': '1.50', 'panjang': '2.00'},
    'M': {'pendek': '1.50', 'panjang': '2.00'},
    'L': {'pendek': '1.75', 'panjang': '2.25'},
    'XL': {'pendek': '2.00', 'panjang': '2.50'},
    'XXL': {'pendek': '2.25', 'panjang': '2.75'},
  };

  void processGeneration() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    generatedModel3DUrl.value = 'assets/scene.glb'; 
    isLoading.value = false;
  }

  void updateFabricRequirement() {
    String sleeveType = isLongSleeve.value ? 'panjang' : 'pendek';
    fabricResult.value = sizeData[selectedSize.value]![sleeveType]!;
    
    // Logika sederhana penentuan bahan bagus
    if (selectedSize.value == 'XL' || selectedSize.value == 'XXL') {
      recommendedMaterial.value = "Katun Poplin atau Sutra (Bahan jatuh dan adem)";
    } else {
      recommendedMaterial.value = "Katun Primisima (Kualitas ekspor, halus)";
    }
  }
}