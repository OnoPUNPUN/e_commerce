import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/features/auth/presentation/controllers/main_navbar_controller.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_bar_icon.dart';
import 'package:e_commerce/features/auth/presentation/widgets/home_banner_slider.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              HomeBannerSlider(),
              const SizedBox(height: 16),
              _buildSectionHeader(
                context,
                title: "All Categories",
                onTap: () {
                  ref.read(mainNavbarProvider.notifier).moveToCategories();
                },
              ),
              _buildCategoriesList(),
              _buildSectionHeader(context, title: "Popular", onTap: () {}),
              _buildSectionHeader(context, title: "New", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildCategoriesList() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 10,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ProductCategoriesItem();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 14);
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required Function()? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onTap, child: Text('See All')),
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
}
