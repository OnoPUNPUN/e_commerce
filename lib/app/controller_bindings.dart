import 'package:e_commerce/features/auth/presentation/controllers/main_navbar_controller.dart';
import 'package:get/get.dart';


class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavbarController());
  }
}
