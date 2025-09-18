import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/utils/constans.dart';

class TotalPriceAndCartSection extends StatelessWidget {
  const TotalPriceAndCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
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
              Text("Price", style: TextStyle(color: Colors.black38)),
              Text(
                "${tkSign}100",
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {}, child: Text("Add To Cart")),
          ),
        ],
      ),
    );
  }
}
