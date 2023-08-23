import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/categories_screen/categories_screen.dart';
import 'package:ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/screens/profile_screen/profile_screen.dart';
import 'package:ecommerce_app/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    // final addProductController = Get.put(AddProductController());
    final PageController pageController = PageController();
    controller.username;
    final navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: 'Categories'),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: 'Card'),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: 'Account'),
    ];

    final navBody = [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const ExitDialog();
          },
        );
        return false;
      },
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          itemCount: navBody.length,
          itemBuilder: (context, index) {
            return navBody[index];
          },
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            items: navbarItem,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.currentNavIndex.value = value;
              pageController.jumpToPage(value);
            },
          ),
        ),
      ),
    );
  }
}
