import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/presentation/widgets/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final MainNavbarController navBarController =
      Get.find<MainNavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
        leading: IconButton(
          onPressed: () {
            navBarController.backToHome();
          },
          icon: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          //return FittedBox(child: ProductCard());
        },
      ),
    );
  }
}
