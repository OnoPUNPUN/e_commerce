import 'package:e_commerce/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  static const String name = '/product-list';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return FittedBox(child: ProductCard());
        },
      ),
    );
  }
}
