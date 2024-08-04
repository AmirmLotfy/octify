import 'package:flutter/material.dart';
import 'package:octify/core/design/app_image.dart';

class AppBack extends StatelessWidget {
  final VoidCallback? onPress;

  const AppBack({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress ??
            () {
              Navigator.pop(context);
            },
        child: const AppImage("arrow_left.svg"));
  }
}
