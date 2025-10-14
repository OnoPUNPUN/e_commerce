import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CenterCicularProgress extends StatelessWidget {
  final double? size;

  const CenterCicularProgress({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.themeColor,
      )
    );
  }
}
