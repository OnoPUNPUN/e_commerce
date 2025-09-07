import 'package:e_commerce/features/auth/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Categories"),
          leading: BackButton(onPressed: _backToHome),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return FittedBox(child: ProductCategoriesItem());
            },
          ),
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainNavbarController>().backToHome();
  }
}
