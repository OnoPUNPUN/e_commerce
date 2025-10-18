import 'package:e_commerce/features/review/presentation/screen/create_review_screen.dart';
import 'package:e_commerce/features/review/presentation/screen/review_screen.dart';
import 'package:e_commerce/features/shared/presentation/screen/bottom_navbar_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/otp_verificatio_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../features/products/presentation/screen/product_details_screen.dart';
import '../features/products/presentation/screen/product_list_screen.dart';
import '../features/shared/data/models/category_model.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = SplashScreen();
  } else if (settings.name == SignInScreen.name) {
    screen = SignInScreen();
  } else if (settings.name == SignUpScreen.name) {
    screen = SignUpScreen();
  } else if (settings.name == OtpVerificationScreen.name) {
    final String email = settings.arguments as String;
    screen = OtpVerificationScreen(email: email);
  } else if (settings.name == BottomNavbarScreen.name) {
    screen = BottomNavbarScreen();
  } else if (settings.name == ProductListScreen.name) {
    final category = settings.arguments as CategoryModel;
    screen = ProductListScreen(category: category);
  } else if (settings.name == ProductDetailsScreen.name) {
    final String productId = settings.arguments as String;
    screen = ProductDetailsScreen(productId: productId);
  } else if (settings.name == ReviewScreen.name) {
    final String productId = settings.arguments as String;
    screen = ReviewScreen(productId: productId);
  } else if (settings.name == CreateReviewScreen.name) {
    final String productId = settings.arguments as String;
    screen = CreateReviewScreen(productId: productId);
  }
  return MaterialPageRoute(builder: (ctx) => screen);
}
