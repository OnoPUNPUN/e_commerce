import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/products/presentation/widgets/color_picker.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_image_slider.dart';
import 'package:e_commerce/features/products/presentation/widgets/size_picker.dart';
import 'package:e_commerce/features/review/presentation/screen/review_screen.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:e_commerce/features/shared/presentation/widgets/show_snack_bar.dart';
import 'package:e_commerce/features/wish/presentation/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_details_controller.dart';
import '../widgets/total_price_and_cart_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = "/product-details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      ProductDetailsController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsController.getProductDetails(widget.productId);
    });
  }

  Future<void> _navigateToReviews(String productId) async {
    Navigator.pushNamed(context, ReviewScreen.name, arguments: productId);
  }

  Future<void> _toggleWishlist(String productId) async {
    try {
      final WishlistController wishlistController =
          Get.find<WishlistController>();

      if (wishlistController.isInWishlist(productId)) {
        // Remove from wishlist
        String? wishlistItemId = wishlistController.getWishlistItemId(
          productId,
        );
        if (wishlistItemId != null) {
          bool isSuccess = await wishlistController.removeFromWishlist(
            wishlistItemId,
          );
          if (isSuccess) {
            showSnackbarMessage(context, 'Removed from wishlist');
          } else {
            showSnackbarMessage(
              context,
              wishlistController.errorMessage ??
                  'Failed to remove from wishlist',
            );
          }
        }
      } else {
        // Add to wishlist
        bool isSuccess = await wishlistController.addToWishlist(productId);
        if (isSuccess) {
          showSnackbarMessage(context, 'Added to wishlist');
        } else {
          showSnackbarMessage(
            context,
            wishlistController.errorMessage ?? 'Failed to add to wishlist',
          );
        }
      }
    } catch (e) {
      showSnackbarMessage(context, 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: GetBuilder<ProductDetailsController>(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.getProductDetailsInProgress) {
            return const CenterCicularProgress();
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          final product = controller.productDetails;

          if (product == null) {
            return const Center(child: Text("No product details found."));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageSlider(imageUrls: product.photos),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              product.title ?? "",
                              style: textTheme.bodyLarge,
                            ),

                            // Rating + Reviews + Fav + Quantity
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  product.rating,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      _navigateToReviews(product.id),
                                  child: const Text(
                                    'Reviews',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                GetBuilder<WishlistController>(
                                  builder: (wishlistController) {
                                    final isInWishlist = wishlistController
                                        .isInWishlist(product.id);
                                    return GestureDetector(
                                      onTap: () => _toggleWishlist(product.id),
                                      child: Card(
                                        color: isInWishlist
                                            ? Colors.red
                                            : AppColors.themeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Icon(
                                            isInWishlist
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 80,
                                  child: IncDecButton(onChange: (int value) {}),
                                ),
                              ],
                            ),

                            // Color Section
                            if (product.colors.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              const Text(
                                'Color',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 6),
                              ColorPicker(
                                colors: product.colors,
                                onSelected: (String color) {},
                              ),
                            ],

                            // Size Section
                            if (product.sizes.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              const Text(
                                'Size',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 6),
                              SizePicker(
                                sizes: product.sizes,
                                onSelected: (String size) {},
                              ),
                            ],

                            // Description
                            const SizedBox(height: 8),
                            const Text(
                              'Description',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              product.description ?? '',
                              style: const TextStyle(
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
              ),

              TotalPriceAndCartSection(productModel: product),
            ],
          );
        },
      ),
    );
  }
}
