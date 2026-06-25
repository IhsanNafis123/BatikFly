import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../desain/controllers/desain_controller.dart';
import '../../fitting/controllers/fitting_controller.dart';
import '../../artikel/controllers/gallery_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<NavbarController>(
      () => NavbarController(),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );

    Get.lazyPut<DesainController>(
      () => DesainController(),
      fenix: true,
    );

    Get.lazyPut<FittingController>(
      () => FittingController(),
      fenix: true,
    );

    Get.lazyPut<GalleryController>(
      () => GalleryController(),
      fenix: true,
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
  }
}