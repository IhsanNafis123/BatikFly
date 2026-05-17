import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NavbarController extends GetxController {

  var currentIndex = 0.obs;

  void changeIndex(int index) {

    currentIndex.value = index;

    switch (index) {

      case 0:
        Get.offAllNamed(Routes.HOME);
        break;

      case 1:
        Get.offAllNamed(Routes.DESAIN);
        break;

      case 2:
        Get.offAllNamed(Routes.FITTING);
        break;

      case 3:
        Get.offAllNamed(Routes.GALLERY);
        break;

      case 4:
        Get.offAllNamed(Routes.PROFILE);
        break;
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}