import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/show_snack_bar.dart';
import 'package:e_commerce/features/wish/presentation/controller/wishlist_controller.dart';
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
  final WishlistController wishlistController = Get.find<WishlistController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistController.getWishlist();
    });
  }

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
      body: GetBuilder<WishlistController>(
        builder: (controller) {
          if (controller.inProgress) {
            return CenterCicularProgress();
          } else if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.errorMessage ?? ''),
                  ElevatedButton(
                    onPressed: () => controller.getWishlist(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (controller.wishlistItemList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add items you love to your wishlist',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.wishlistItemList.length,
            itemBuilder: (context, index) {
              final wishlistItem = controller.wishlistItemList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ProductCard(
                  productModel: wishlistItem.product,
                  onWishlistToggle: () => _removeFromWishlist(wishlistItem.id),
                  isInWishlist: true,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _removeFromWishlist(String wishlistItemId) async {
    bool isSuccess = await wishlistController.removeFromWishlist(
      wishlistItemId,
    );

    if (isSuccess) {
      showSnackbarMessage(context, 'Item removed from wishlist');
    } else {
      showSnackbarMessage(
        context,
        wishlistController.errorMessage ?? 'Failed to remove item',
      );
    }
  }
}
