import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/app/controllers/auth_controller.dart';
import 'package:e_commerce/app/utils/constans.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/shared/data/models/product_details_model.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/show_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_to_cart_controller.dart';

class TotalPriceAndCartSection extends StatefulWidget {
  const TotalPriceAndCartSection({super.key, required this.productModel});

  final ProductDetailsModel productModel;

  @override
  State<TotalPriceAndCartSection> createState() =>
      _TotalPriceAndCartSectionState();
}

class _TotalPriceAndCartSectionState extends State<TotalPriceAndCartSection> {
  final AddToCartController _cartController = AddToCartController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price', style: TextStyle(color: Colors.black38)),
              Text(
                '$tkSign${widget.productModel.currentPrice ?? ''}',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),

          GetBuilder<AddToCartController>(
            init: _cartController,
            builder: (controller) {
              return SizedBox(
                width: 120,
                child: FilledButton(
                  onPressed: controller.addToCartInProgress
                      ? null
                      : _onTapAddToCartButton,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                  ),
                  child: controller.addToCartInProgress
                      ? const CenterCicularProgress(size: 20)
                      : const Text('Add to Cart'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCartButton() async {
    final authController = Get.find<AuthController>();

    if (await authController.isUserAlreadyLoggedIn()) {
      final success = await _cartController.addToCart(widget.productModel.id);
      if (success) {
        showSnackbarMessage(context, 'Added to cart');
      } else {
        showSnackbarMessage(
          context,
          _cartController.errorMessage ?? 'Something went wrong',
        );
      }
    } else {
      Navigator.pushNamed(context, SignInScreen.name);
    }
  }
}
