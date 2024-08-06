import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/design/second_app_bar.dart';
import '../../core/theme.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Reset Password"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              AppInput(
                label: "New Password",
                inputType: InputType.password,
                prefix: "password.svg",
                hint: "Enter New Password",
                validator: (value) {
                  //todo make the validation
                  return null;
                },
              ),
              AppInput(
                label: "Confirm New Password",
                inputType: InputType.password,
                prefix: "password.svg",
                hint: "Enter Confirm New Password",
                validator: (value) {
                  //todo make the validation
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Confirm",
        isLoading: isLoading,
        type: ButtonType.bottomNav,
        onPress: () async {
          if (formKey.currentState!.validate()) {
            isLoading = true;
            setState(() {});

            await Future.delayed(const Duration(seconds: 2));
            isLoading = false;
            setState(() {});

            navigateTo(const LoginView(), keepHistory: false);
          }
        },
      ),
    );
  }
}
