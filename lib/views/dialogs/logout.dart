import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool isLoading = false;

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
              child: AppButton(
                isLoading: isLoading,
                onPress: () async {
                  isLoading = true;
                  setState(() {});
                  await GoogleSignIn().disconnect();
                  await FirebaseAuth.instance.signOut();
                  navigateTo(const LoginView(), keepHistory: false);
                  // await Future.delayed(const Duration(seconds: 2));
                  isLoading = false;
                  setState(() {});
                  },
                text: "Logout",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: OutlinedButton(
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
