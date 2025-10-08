import 'package:e_commerce/app/set_up_network_client.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/controllers/signup_controller.dart';
import 'package:e_commerce/features/home/presentation/controller/home_slides_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/controllers/verify_otp_controller.dart';
import 'controllers/auth_controller.dart';


class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavbarController());
    Get.put(setUpNetworkClient());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(HomeSlidesController());
    Get.put(CategoryController());
  }
}
