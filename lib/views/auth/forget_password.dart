import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/verification.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/design/second_app_bar.dart';
import '../../core/theme.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Forgot Password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Center(
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: AppTheme.fontFamily2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your email, we will send a\nverification code to email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 30.h),
            const AppInput(
              label: "Email Address",
              prefix: "mail.svg",
              hint: "Enter Email Address",
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Submit",
        type: ButtonType.bottomNav,
        onPress: () {
          navigateTo(const VerificationView());
        },
      ),
    );
  }
}
