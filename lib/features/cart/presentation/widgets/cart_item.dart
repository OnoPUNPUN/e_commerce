import 'package:e_commerce/app/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../../shared/presentation/widgets/show_snack_bar.dart';
import '../../data/models/cart_item_model.dart';
import '../controller/cart_list_controller.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16),
      shadowColor: AppColors.themeColor.withOpacity(0.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(),
            child: Image.network(
              cartItemModel.product.photos.isEmpty
                  ? ''
                  : cartItemModel.product.photos.first,
              height: 80,
              width: 80,
              errorBuilder: (_, __, ___) => Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                child: Icon(Icons.error_outline),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItemModel.product.title,
                              style: TextTheme.of(context).titleSmall,
                            ),
                            Text(
                              'Size: ${cartItemModel.size ?? 'Nil'}  Color: ${cartItemModel.color ?? 'Nil'}',
                              style: TextTheme.of(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _deleteCartItem(context),
                        icon: Icon(Icons.delete_forever_outlined),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$tkSign${cartItemModel.product.currentPrice}',
                        style: TextTheme.of(
                          context,
                        ).titleSmall?.copyWith(color: AppColors.themeColor),
                      ),
                      IncDecButton(
                        onChange: (int value) {
                          Get.find<CartListController>().updateCart(
                            cartItemModel.id,
                            value,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCartItem(BuildContext context) async {
    final CartListController cartController = Get.find<CartListController>();

    // Show confirmation dialog
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove Item'),
        content: const Text(
          'Are you sure you want to remove this item from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      bool isSuccess = await cartController.deleteCartItem(cartItemModel.id);

      if (context.mounted) {
        if (isSuccess) {
          showSnackbarMessage(context, 'Item removed from cart');
        } else {
          showSnackbarMessage(
            context,
            cartController.errorMessage ?? 'Failed to remove item',
          );
        }
      }
    }
  }
}
