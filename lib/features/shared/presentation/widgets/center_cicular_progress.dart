import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CenterCicularProgress extends StatelessWidget {
  const CenterCicularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.themeColor,
      )
    );
  }
}
