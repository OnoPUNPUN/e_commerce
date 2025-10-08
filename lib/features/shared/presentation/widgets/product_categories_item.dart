import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/products/presentation/screen/product_list_screen.dart';
import 'package:e_commerce/features/shared/data/models/category_model.dart';
import 'package:flutter/material.dart';

class ProductCategoriesItem extends StatelessWidget {
  const ProductCategoriesItem({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: categoryModel.title,
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
            child: Image.network(
              categoryModel.icon,
              height: 32,
              width: 32,
              errorBuilder: (_, __, ___) {
                return Icon(Icons.error_outline, size: 32);
              },
            ),
          ),
          Text(
            _getTitleText(categoryModel.title),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }

  String _getTitleText(String text) {
    if (text.length < 9) {
      return text;
    }
    return '${text.substring(0, 9)}..';
  }
}
