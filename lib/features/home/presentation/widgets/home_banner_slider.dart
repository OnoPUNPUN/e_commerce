import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            height: 180.0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: Duration(milliseconds: 900),
            scrollPhysics: BouncingScrollPhysics(),
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _currentIndex.value = index;
            },
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'text $i',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _currentIndex.value == i
                          ? AppColors.themeColor
                          : null,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
