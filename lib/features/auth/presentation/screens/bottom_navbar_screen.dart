import 'package:e_commerce/features/auth/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/auth/presentation/screens/home_screen.dart';
import 'package:e_commerce/features/categories/presnetation/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarScreen extends ConsumerWidget {
  const BottomNavbarScreen({super.key});

  static const String name = '/bottom-nav-bar';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavbarProvider);
    final mainNavbarNotifier = ref.read(mainNavbarProvider.notifier);

    final List<Widget> screens = [
      const HomeScreen(),
      const CategoriesScreen(),
      const HomeScreen(),
      const HomeScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: mainNavbarNotifier.changeIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Wish'),
          ],
        ),
      ),
    );
  }
}
