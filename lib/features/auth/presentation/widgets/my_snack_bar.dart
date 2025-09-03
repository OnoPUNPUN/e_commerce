import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  final String message;

  MySnackBar({super.key, required this.message})
    : super(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      );
}
