import 'package:e_commerce/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';

class OtpController extends GetxController {
  var secondsRemaining = 120.obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() async {
    while (secondsRemaining.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      secondsRemaining.value--;
    }
  }
}

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});
  static const String name = '/otp-verification';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final OtpController controller = Get.put(OtpController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(width: 100),
              const SizedBox(height: 16),
              Text("Enter OTP Code", style: textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                "A 4 Digit OTP Code has been Sent",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // OTP Input
              PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: AppColors.themeColor,
                  selectedColor: AppColors.themeColor,
                  inactiveColor: Colors.grey.shade400,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),

              // Next Button
              FilledButton(
                onPressed: () {
                  // TODO: verify OTP API call
                },
                child: const Text("Next"),
              ),
              const SizedBox(height: 16),

              // Timer with GetX
              Obx(() {
                if (controller.secondsRemaining.value > 0) {
                  return Text(
                    "This code will expire in ${controller.secondsRemaining.value}s",
                    style: textTheme.bodyMedium,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),

              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (controller.secondsRemaining.value == 0) {
                    controller.secondsRemaining.value = 120;
                    controller.onInit();
                  }
                },
                child: Text(
                  "Resend Code",
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
