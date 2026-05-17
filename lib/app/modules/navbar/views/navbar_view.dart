import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {

  const NavbarView({super.key});

  @override
Widget build(BuildContext context) {

    return Obx(
      () => BottomNavigationBar(

        type: BottomNavigationBarType.fixed,

        backgroundColor: const Color(0xFF141B3A),

        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,

        currentIndex: controller.currentIndex.value,

        onTap: controller.changeIndex,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            label: 'Desain',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Fitting',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Artikel',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}