import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/auth/login.dart';
import 'package:octify/views/auth/register.dart';


class LoginOrRegisterView extends StatelessWidget {
  const LoginOrRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 3,),
              AppImage(
                "",
                height: 114.h,
                width: 120.w,
              ),
              SizedBox(height: 24.h),
              Text(
                "Octify",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 64.sp,fontFamily: AppTheme.fontFamily2, fontWeight: FontWeight.w700),
              ),
              const Spacer(flex: 2,),
              const Text(
                "Connect Better, Grow\nTogether",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff3A3A3A),
                  fontFamily: AppTheme.fontFamily2,
                ),
              ),
              SizedBox(height: 44.h),
              FilledButton(
                onPressed: () {
                  navigateTo(const RegisterView());
                },
                child: const Text("Create Account"),
              ),
              TextButton(
                onPressed: () {
                navigateTo(const LoginView());
                },
                child: const Text("Log In to Your Account"),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
