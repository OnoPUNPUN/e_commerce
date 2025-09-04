import 'package:e_commerce/features/auth/presentation/screens/bottom_navbar_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/otp_verificatio_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = SplashScreen();
  } else if (settings.name == SignInScreen.name) {
    screen = SignInScreen();
  } else if (settings.name == SignUpScreen.name) {
    screen = SignUpScreen();
  } else if (settings.name == OtpVerificationScreen.name) {
    screen = OtpVerificationScreen();
  } else if (settings.name == BottomNavbarScreen.name) {
    screen = BottomNavbarScreen();
  }
  return MaterialPageRoute(builder: (ctx) => screen);
}
