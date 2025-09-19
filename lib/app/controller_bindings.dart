import 'package:e_commerce/app/set_up_network_client.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_navbar_controller.dart';
import 'package:get/get.dart';


class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavbarController());
    Get.put(setUpNetworkClient());
  }
}
