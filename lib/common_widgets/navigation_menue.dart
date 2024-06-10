import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/colors.dart';
import '../consts/strings.dart';
import '../views/home_Screen/home_Screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavgationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: primaryColor,
          backgroundColor: primaryColor,
          height: 73,
          overlayColor: WidgetStateProperty.all(primaryColor),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined), label: home),
            NavigationDestination(
                icon: Icon(Icons.list_alt_outlined), label: orders),
            NavigationDestination(
                icon: Icon(Icons.person_2_outlined), label: profile),
          ],

        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],),
    );
  }
}

class NavgationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(), Container(), Container(),];
}
