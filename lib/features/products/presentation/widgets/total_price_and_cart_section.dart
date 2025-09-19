import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';

class TotalPriceAndCartSection extends StatelessWidget {
  const TotalPriceAndCartSection({super.key, required this.buttonName, required this.heading, required this.price});
  final String buttonName;
  final String heading;
  final String price;

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
              Text(heading, style: TextStyle(color: Colors.black38)),
              Text(
                price,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {}, child: Text(buttonName)),
          ),
        ],
      ),
    );
  }
}
