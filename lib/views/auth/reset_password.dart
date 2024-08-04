import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/design/second_app_bar.dart';
import '../../core/theme.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Reset Password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Center(
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: AppTheme.fontFamily2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your email address associated\nwith your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 30.h),
            const AppInput(
              label: "New Password",
              inputType: InputType.password,
              prefix: "password.svg",
              hint: "Enter New Password",
            ),
            const AppInput(
              label: "Confirm New Password",
              inputType: InputType.password,
              prefix: "password.svg",
              hint: "Enter Confirm New Password",
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Confirm",
        type: ButtonType.bottomNav,
        onPress: () {
          navigateTo(const LoginView(), keepHistory: false);
        },
      ),
    );
  }
}
