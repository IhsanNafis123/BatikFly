import 'package:get/get.dart';

import '../controllers/fitting_controller.dart';

class FittingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FittingController>(
      () => FittingController(),
    );
  }
}
