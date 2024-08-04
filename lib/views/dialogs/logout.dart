import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(24.r),
      children: [
        Text(
          "Are You Sure You Want To\nLog Out Your Account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        AppImage(
          "logout_dialog.svg",
          height: 62.h,
          width: 62.h,
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  navigateTo(const LoginView());
                },
                child: const Text("Logout"),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
