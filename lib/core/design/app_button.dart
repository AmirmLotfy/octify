import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { normal, outlined, bottomNav }

class AppButton extends StatelessWidget {
  final bool isLoading;
  final ButtonType type;
  final String text;
  final VoidCallback? onPress;

  const AppButton(
      {super.key,
      this.isLoading = false,
      required this.text,
      this.onPress,
      this.type = ButtonType.normal});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.normal:
        if (isLoading) {
          return FilledButton.icon(
            onPressed: null,
            icon: SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(strokeWidth: .8),
            ),
            label: Text(text),
          );
        }
        return FilledButton(
          onPressed: onPress,
          child: Text(text),
        );
      case ButtonType.outlined:
        if (isLoading) {
          return OutlinedButton.icon(
            onPressed: null,
            icon: SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(strokeWidth: .8),
            ),
            label: Text(text),
          );
        }
        return OutlinedButton(
          onPressed: onPress,
          child: Text(
            text,
          ),
        );
      case ButtonType.bottomNav:
        return Padding(
          padding: EdgeInsets.all(24.r).copyWith(top: 8.h),
          child: AppButton(
            text: text,
            onPress: onPress,
          ),
        );
    }
  }
}
