import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/shared/presentation/screen/bottom_navbar_screen.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../data/verify_otp_request_model.dart';
import '../controllers/verify_otp_controller.dart';

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

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  static const String name = '/otp-verification';

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final VerifyOtpController _verifyOtpController =
      Get.find<VerifyOtpController>();

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
                controller: _otpTEController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),

              GetBuilder<VerifyOtpController>(
                builder: (verifyController) {
                  return Visibility(
                    visible: verifyController.verifyOtpInProgress == false,
                    replacement: CenterCicularProgress(),
                    child: FilledButton(
                      onPressed: _onTapVerifyButton,
                      child: const Text("Next"),
                    ),
                  );
                },
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

              const SizedBox(height: 16),
              TextButton(
                onPressed: _onTapBackToLoginButton,
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapVerifyButton() {
    if (_otpTEController.text.length != 4) {
      showSnackbarMessage(context, "Please enter a valid 4-digit OTP");
      return;
    }
    _verifyOtp();
  }

  Future<void> _verifyOtp() async {
    VerifyOtpRequestModel model = VerifyOtpRequestModel(
      email: widget.email,
      otp: _otpTEController.text,
    );

    final bool isSuccess = await _verifyOtpController.verifyOtp(model);
    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
        _verifyOtpController.userModel!,
        _verifyOtpController.accessToken!,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottomNavbarScreen.name,
        (predicate) => false,
      );
    } else {
      showSnackbarMessage(context, _verifyOtpController.errorMessage!);
    }
  }

  void _onTapBackToLoginButton() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (p) => false);
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
