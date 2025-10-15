import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'core/services/network_caller.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorize: _onUnAuthorize,
    accessToken: () {
      return Get.find<AuthController>().accessToken ?? '';
    },
  );
}

Future<void> _onUnAuthorize() async {
  await Get.find<AuthController>().clearUserData();
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
    (predicate) => false,
  );
}
