import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_bar_icon.dart';
import 'package:e_commerce/features/auth/presentation/widgets/home_banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            HomeBannerSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (String? text) {},
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
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
