import 'package:get/get.dart';

class HomeController extends GetxController {

  // Bottom Navigation Index
  RxInt selectedIndex = 0.obs;

  // Change Bottom Navigation
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}