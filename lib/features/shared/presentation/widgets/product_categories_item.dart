import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/products/presentation/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

class ProductCategoriesItem extends StatelessWidget {
  const ProductCategoriesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: 'Electronics',
        );
      },
      child: Column(
        spacing: 6,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.computer, size: 32, color: AppColors.themeColor),
          ),
          Text(
            "Electronics",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }
}
