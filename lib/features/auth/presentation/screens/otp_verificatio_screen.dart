import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/auth/presentation/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';

class OtpVerificationScreen extends ConsumerWidget {
  const OtpVerificationScreen({super.key});
  static const String name = '/otp-verification';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final secondsRemaining = ref.watch(otpProvider);

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

              // Timer with Riverpod
              if (secondsRemaining > 0)
                Text(
                  "This code will expire in ${secondsRemaining}s",
                  style: textTheme.bodyMedium,
                )
              else
                const SizedBox.shrink(),

              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (secondsRemaining == 0) {
                    ref.read(otpProvider.notifier).resetTimer();
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
