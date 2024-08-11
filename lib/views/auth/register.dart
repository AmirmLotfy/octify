import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/auth/login.dart';
import 'package:octify/views/auth/verification.dart';
import 'package:octify/views/home/view.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import '../../core/logic/input_validator.dart';
import 'components/login_or_register.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController(text: "Amr");
  final lastNameController = TextEditingController(text: "Bakr");
  final phoneController = TextEditingController(text: "01027545022");
  final emailController = TextEditingController(text: "frameless.com@gmail.com");
  final passwordController = TextEditingController(text: "123456789");

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
                  controller: firstNameController,
                  label: "First Name",
                  prefix: "user_name.svg",
                  hint: "Enter First Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First Name must be not empty";
                    }
                    return null;
                  },
                ),
                AppInput(
                  controller: lastNameController,
                  label: "Last Name",
                  prefix: "user_name.svg",
                  hint: "Enter Last Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last Name must be not empty";
                    }
                    return null;
                  },
                ),
                AppInput(
                  controller: emailController,
                  label: "Email Address",
                  prefix: "mail.svg",
                  hint: "Enter Email Address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidator.emailValidator(value!),
                ),
                AppInput(
                  controller: phoneController,
                  label: "Phone Number",
                  prefix: "phone.svg",
                  hint: "Enter Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone must be not empty";
                    }
                    //todo make the validation
                    return null;
                  },
                ),
                AppInput(
                  controller: passwordController,
                  label: "Password",
                  inputType: InputType.password,
                  marginBottom: 30.h,
                  prefix: "password.svg",
                  hint: "Enter Password",
                  validator: (value) =>
                      InputValidator.passwordLoginValidator(value!),
                ),
                AppButton(
                  isLoading: isLoading,
                  onPress: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        await FirebaseDatabase.instance
                            .ref()
                            .child("users")
                            .child(credential.user!.uid)
                            .set({
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                          "phone": phoneController.text,
                          "email": emailController.text,
                          "image": ""
                        });
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        await FirebaseAuth.instance.signOut();
                        showMessage(
                            "Signed up Success Please Verify your email",
                            type: MessageType.success);
                        navigateTo(const LoginView(), keepHistory: false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showMessage("The password provided is too weak.");
                        } else if (e.code == 'email-already-in-use') {
                          showMessage(
                              "The account already exists for that email.");
                        }
                      } catch (e) {
                        showMessage(e.toString());
                      }
                      isLoading = false;
                      setState(() {});
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
