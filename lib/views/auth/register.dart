import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/auth/verification.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import 'components/login_or_register.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  bool isLoading =false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                AppImage(
                  "logo.png",
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
                    "Create Your Account",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppTheme.fontFamily2),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Please enter info to create\naccount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                SizedBox(height: 30.h),
                 AppInput(
                  label: "First Name",
                  prefix: "user_name.svg",
                  hint: "Enter First Name",
                  validator: (value) {    //todo make the validation
                    return null;
                  },
                ),
                 AppInput(
                  label: "Last Name",
                  prefix: "user_name.svg",
                  hint: "Enter Last Name",
                  validator: (value) {    //todo make the validation
                    return null;
                  },
                ),
                 AppInput(
                  label: "Email Address",
                  prefix: "mail.svg",
                  hint: "Enter Email Address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {    //todo make the validation
                    return null;
                  },
                ),
                 AppInput(
                  label: "Phone Number",
                  prefix: "phone.svg",
                  hint: "Enter Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {    //todo make the validation
                    return null;
                  },
                ),
                AppInput(
                  label: "Password",
                  inputType: InputType.password,
                  marginBottom: 30.h,
                  prefix: "password.svg",
                  hint: "Enter Password",
                  validator: (value) {
                    //todo make the validation
                    return null;
                  },
                ),
                AppButton(
                  isLoading: isLoading,
                  onPress: () async{
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});

                      await Future.delayed(const Duration(seconds: 2));
                      isLoading = false;
                      setState(() {});

                      navigateTo(const VerificationView());
                    }

                  },
                  text: "Sign Up",
                ),
                const LoginOrRegister(
                  isLogin: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
