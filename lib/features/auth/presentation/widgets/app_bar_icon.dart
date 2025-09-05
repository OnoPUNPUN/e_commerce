import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.onPressed,
    required this.iconData,
  });
  final void Function()? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        radius: 18,
        child: Icon(iconData, color: Colors.black),
      ),
    );
  }
}
