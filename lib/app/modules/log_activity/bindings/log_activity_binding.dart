import 'package:get/get.dart';

import '../controllers/log_activity_controller.dart';

class LogActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogActivityController>(
      () => LogActivityController(),
    );
  }
}
