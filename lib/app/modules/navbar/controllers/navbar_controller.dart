import 'package:get/get.dart';

class NavbarController extends GetxController {

  final currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

}