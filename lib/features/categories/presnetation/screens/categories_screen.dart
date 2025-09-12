import 'package:e_commerce/features/auth/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome(ref);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Categories"),
          leading: BackButton(onPressed: () => _backToHome(ref)),
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
              return const FittedBox(child: ProductCategoriesItem());
            },
          ),
        ),
      ),
    );
  }

  void _backToHome(WidgetRef ref) {
    ref.read(mainNavbarProvider.notifier).backToHome();
  }
}
