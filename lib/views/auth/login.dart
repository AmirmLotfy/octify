import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/forget_password.dart';
import 'package:octify/views/home/view.dart';

import '../../core/theme.dart';
import 'components/login_or_register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              AppImage(
                "",
                height: 64.h,
                width: 67.w,
              ),
              SizedBox(height: 16.h),
              Center(
                child: Text(
                  "Octify",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: const Color(0xff3A3A3A),

                    fontFamily: AppTheme.fontFamily2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Welcome back! Please enter\nyour details",
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
              const AppInput(
                label: "Password",
                inputType: InputType.password,
                prefix: "password.svg",
                hint: "Enter Password",
              ),
              GestureDetector(
                onTap: () {
                  isRememberMe = !isRememberMe;
                  setState(() {});
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Checkbox(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isRememberMe,
                        onChanged: (value) {
                          isRememberMe = !isRememberMe;
                          setState(() {});
                        },
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          navigateTo(const ForgetPasswordView());
                        },
                        child: const Text("Forget Password?"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FilledButton(
                onPressed: () {
                  navigateTo(const HomeView(),keepHistory: false);
                },
                child: const Text("Continue"),
              ),
              const LoginOrRegister()
            ],
          ),
        ),
      ),
    );
  }
}
