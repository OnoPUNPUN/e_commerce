import 'package:e_commerce/app/set_up_network_client.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/controllers/signup_controller.dart';
import 'package:e_commerce/features/home/presentation/controller/home_slides_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/controllers/verify_otp_controller.dart';
import '../features/cart/presentation/controller/cart_list_controller.dart';
import '../features/shared/presentation/controllers/new_product_controller.dart';
import '../features/shared/presentation/controllers/popular_product_controller.dart';
import '../features/shared/presentation/controllers/special_product_controller.dart';
import '../features/wish/presentation/controller/wishlist_controller.dart';
import '../features/review/presentation/controller/review_controller.dart';
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
    Get.put(CartListController());

    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(WishlistController());
    Get.put(ReviewController());
  }
}
