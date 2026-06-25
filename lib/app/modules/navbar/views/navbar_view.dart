import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../desain/views/desain_view.dart';
import '../../fitting/views/fitting_view.dart';
import '../../artikel/views/gallery_view.dart';
import '../../profile/views/profile_view.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children:[
            HomeView(),
            DesainView(),
            FittingView(),
            GalleryView(),
            ProfileView(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          backgroundColor: const Color(0xFF141B3A),

          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,

          currentIndex: controller.currentIndex.value,

          onTap: controller.changeIndex,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.brush),
              label: "Desain",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.checkroom),
              label: "Fitting",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "Artikel",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}