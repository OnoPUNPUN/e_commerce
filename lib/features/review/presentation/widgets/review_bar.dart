import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../screen/create_review_screen.dart';

class ReviewBar extends StatelessWidget {
  const ReviewBar({super.key, required this.buttonName, required this.heading});

  final String buttonName;
  final String heading;

  @override
  Widget build(BuildContext context) {
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
              Text(
                heading,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: FilledButton(
              style: FilledButton.styleFrom(shape: CircleBorder()),
              onPressed: () async {
                final authController = Get.find<AuthController>();
                if (await authController.isUserAlreadyLoggedIn()) {
                  Navigator.pushNamed(context, CreateReviewScreen.name);
                } else {
                  Navigator.pushNamed(context, SignInScreen.name);
                }
              },
              child: Text(
                buttonName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
