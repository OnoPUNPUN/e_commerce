import 'package:e_commerce/features/home/presentation/controller/home_slides_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/cart/presentation/screen/cart_screen.dart';
import 'package:e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:e_commerce/features/categories/presnetation/screens/categories_screen.dart';
import 'package:e_commerce/features/wish/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/category_controller.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  static const String name = '/bottom-nav-bar';

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeSlidesController>().getHomeSliders();
    Get.find<CategoryController>().getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavbarController>(
      builder: (mainNavbarController) {
        return Scaffold(
          body: _screens[mainNavbarController.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: NavigationBar(
              selectedIndex: mainNavbarController.currentIndex,
              onDestinationSelected: mainNavbarController.changeIndex,
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: 'Wish',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
