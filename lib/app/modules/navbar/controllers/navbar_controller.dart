import 'package:get/get.dart';

class NavbarController extends GetxController {

  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;

      case 1:
        Get.offAllNamed('/desain');
        break;

      case 2:
        Get.offAllNamed('/fitting');
        break;

      case 3:
        Get.offAllNamed('/artikel');
        break;

      case 4:
        Get.offAllNamed('/profil');
        break;
    }
  }
}