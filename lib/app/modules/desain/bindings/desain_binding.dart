import 'package:get/get.dart';

import '../controllers/desain_controller.dart';

class DesainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesainController>(
      () => DesainController(),
    );
  }
}
