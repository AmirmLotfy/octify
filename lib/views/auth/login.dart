import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/logic/input_validator.dart';
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
  bool isRememberMe = CacheHelper.isRememberMe;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (isRememberMe) {
      emailController.text = CacheHelper.email;
      passwordController.text = CacheHelper.password;
    }
  }

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
                  height: 120.h,
                  width: 120.h,
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
                AppInput(
                  label: "Email Address",
                  controller: emailController,
                  prefix: "mail.svg",
                  hint: "Enter Email Address",
                  validator: (value) => InputValidator.emailValidator(value!),
                  keyboardType: TextInputType.emailAddress,
                ),
                AppInput(
                  label: "Password",
                  controller: passwordController,
                  inputType: InputType.password,
                  prefix: "password.svg",
                  hint: "Enter Password",
                  validator: (value) =>
                      InputValidator.passwordLoginValidator(value!),
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                AppButton(
                  isLoading: isLoading,
                  onPress: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);

                        if (credential.user!.emailVerified) {
                          await CacheHelper.setRememberMe(isRememberMe);
                          if (isRememberMe) {
                            await CacheHelper.saveEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                          final snapShot = await FirebaseDatabase.instance
                              .ref("users")
                              .child(credential.user!.uid)
                              .get();
                          final details = snapShot.value as Map;
                          await CacheHelper.saveUserData(
                            image: details["image"] ?? "",
                            email: details["email"] ?? "",
                            firstName: details["firstName"] ?? "",
                            lastName: details["lastName"] ?? "",
                            phone: details["phone"] ?? "",
                          );
                          showMessage("Login Success",
                              type: MessageType.success);
                          navigateTo(const HomeView(), keepHistory: false);
                        } else {
                          showMessage(
                            "Please Verify your email before login",
                            type: MessageType.warning,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showMessage("No user found for that email.");
                        } else if (e.code == 'wrong-password') {
                          showMessage("Wrong password provided for that user.");
                        }else
                          {
                            showMessage(e.code);
                          }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: "Sign In",
                ),
                const LoginOrRegister()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
