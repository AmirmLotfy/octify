import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/views/home/view.dart';

import '../../../core/logic/helper_methods.dart';
import '../register.dart';

class LoginOrRegister extends StatelessWidget {
  final bool isLogin;
  final double? marginTop;

  const LoginOrRegister({super.key, this.isLogin = true, this.marginTop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                  child: Divider(
                endIndent: 24.w,
                indent: 24.w,
              )),
              Text(
                "or",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Expanded(
                  child: Divider(
                indent: 24.w,
                endIndent: 24.w,
              )),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              _ItemSocial(
                image: "google.svg",
                onPress: signInWithGoogle,
              ),
              SizedBox(width: 12.w),
              _ItemSocial(
                image: "facebook.png",
                onPress: () {},
              ),
              SizedBox(width: 12.w),
              _ItemSocial(
                image: "apple.svg",
                onPress: () {},
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isLogin
                    ? "Don’t have an account ?"
                    : "Already have an account?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
              ),
              TextButton(
                onPressed: () {
                  if (isLogin) {
                    navigateTo(const RegisterView());
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(isLogin ? "Sign Up" : "Sign In"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future signInWithGoogle() async {
    // if the user don't have account google will create account for him
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // await FirebaseDatabase.instance
    //     .ref()
    //     .child("users")
    //     .child(credential.user!.uid)
    //     .set({
    //   "firstName": credential.,
    //   "lastName": lastNameController.text,
    //   "phone": phoneController.text,
    //   "email": emailController.text,
    // });
    navigateTo(const HomeView(), keepHistory: false);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class _ItemSocial extends StatelessWidget {
  final String image;
  final VoidCallback onPress;

  const _ItemSocial({required this.image, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 38.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          border: Border.all(color: const Color(0xffEEEEEE)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: AppImage(
          image,
          height: 24.h,
          width: 24.h,
        ),
      ),
    ));
  }
}
