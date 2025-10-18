import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/features/home/presentation/controller/home_slides_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/home/presentation/widgets/app_bar_icon.dart';
import 'package:e_commerce/features/home/presentation/widgets/home_banner_slider.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../shared/presentation/controllers/category_controller.dart';
import '../../../shared/presentation/controllers/new_product_controller.dart';
import '../../../shared/presentation/controllers/popular_product_controller.dart';
import '../../../shared/presentation/controllers/special_product_controller.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../../../shared/presentation/widgets/show_snack_bar.dart';
import '../../../wish/presentation/controller/wishlist_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger load more when user scrolls near the bottom
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<PopularProductController>().getPopularProducts();
      Get.find<SpecialProductController>().getSpecialProducts();
      Get.find<NewProductController>().getNewProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(AssetPaths.logoNavSvg),
        ),
        actions: [
          AppBarIcon(iconData: Icons.person_outline, onPressed: () {}),
          AppBarIcon(onPressed: () {}, iconData: Icons.call_outlined),
          AppBarIcon(
            onPressed: () {},
            iconData: Icons.notifications_active_outlined,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              GetBuilder<HomeSlidesController>(
                builder: (controller) {
                  if (controller.getSlidersInprogress) {
                    return SizedBox(
                      height: 180,
                      child: CenterCicularProgress(),
                    );
                  }
                  return HomeBannerSlider(sliders: controller.sliders);
                },
              ),
              const SizedBox(height: 16),
              _buildSectionHeader(
                title: "All Categories",
                onTap: () {
                  Get.find<MainNavbarController>().moveToCategories();
                },
              ),
              _buildCategoriesList(),
              const SizedBox(height: 16),
              _buildSectionHeader(title: "Popular", onTap: () {}),
              _buildPopularProductList(),
              const SizedBox(height: 16),
              _buildSectionHeader(title: "Special", onTap: () {}),
              _buildSpecialProductList(),
              const SizedBox(height: 16),
              _buildSectionHeader(title: "New", onTap: () {}),
              _buildNewProductList(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildCategoriesList() {
    return SizedBox(
      height: 120,
      child: GetBuilder<CategoryController>(
        builder: (controller) {
          if (controller.isInitialLoading) {
            return CenterCicularProgress();
          }
          return ListView.separated(
            itemCount: controller.categorieList.length > 10
                ? 10
                : controller.categorieList.length,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCategoriesItem(
                categoryModel: controller.categorieList[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 14);
            },
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required Function()? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onTap, child: const Text('See All')),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (String? text) {},
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        fillColor: Colors.grey.shade100,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPopularProductList() {
    return GetBuilder<PopularProductController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return SizedBox(height: 150, child: CenterCicularProgress());
        }

        if (controller.productList.isEmpty) {
          return SizedBox(
            height: 150,
            child: Center(child: Text('No popular products found')),
          );
        }

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return GetBuilder<WishlistController>(
                builder: (wishlistController) {
                  return ProductCard(
                    productModel: product,
                    onWishlistToggle: () => _toggleWishlist(product.id),
                    isInWishlist: wishlistController.isInWishlist(product.id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSpecialProductList() {
    return GetBuilder<SpecialProductController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return SizedBox(height: 150, child: CenterCicularProgress());
        }

        if (controller.productList.isEmpty) {
          return SizedBox(
            height: 150,
            child: Center(child: Text('No special products found')),
          );
        }

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return GetBuilder<WishlistController>(
                builder: (wishlistController) {
                  return ProductCard(
                    productModel: product,
                    onWishlistToggle: () => _toggleWishlist(product.id),
                    isInWishlist: wishlistController.isInWishlist(product.id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNewProductList() {
    return GetBuilder<NewProductController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return SizedBox(height: 150, child: CenterCicularProgress());
        }

        if (controller.productList.isEmpty) {
          return SizedBox(
            height: 150,
            child: Center(child: Text('No new products found')),
          );
        }

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return GetBuilder<WishlistController>(
                builder: (wishlistController) {
                  return ProductCard(
                    productModel: product,
                    onWishlistToggle: () => _toggleWishlist(product.id),
                    isInWishlist: wishlistController.isInWishlist(product.id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
