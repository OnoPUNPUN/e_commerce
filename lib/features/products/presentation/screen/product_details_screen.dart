import 'package:e_commerce/app/utils/constans.dart';
import 'package:e_commerce/features/products/presentation/widgets/color_picker.dart';
import 'package:e_commerce/features/review/presentation/screen/review_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../widgets/product_image_slider.dart';
import '../widgets/size_picker.dart';
import '../widgets/total_price_and_cart_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = "/product-details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductImageSlider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nike A123 - New Edition of Jordan Sports\nSave 30%",
                        style: textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 20, color: Colors.amber),
                          const SizedBox(width: 4),
                          const Text('4.2', style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ReviewScreen.name);
                            },
                            child: const Text(
                              'Reviews',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Card(
                            color: AppColors.themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.favorite_outline,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 80,
                            child: IncDecButton(onChange: (int value) {}),
                          ),
                        ],
                      ),
                      Text('Color', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 6),
                      ColorPicker(
                        colors: ['Red', 'White', 'Black'],
                        onSelected: (String color) {},
                      ),
                      const SizedBox(height: 8),
                      Text('Size', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 6),
                      SizePicker(
                        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
                        onSelected: (String size) {},
                      ),
                      const SizedBox(height: 8),
                      Text('Description', style: TextStyle(fontSize: 18)),
                      Text(
                        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book''',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const TotalPriceAndCartSection(
            buttonName: "Add To Cart",
            heading: 'Price',
            price: '${tkSign}100',
          ),
        ],
      ),
    );
  }
}
