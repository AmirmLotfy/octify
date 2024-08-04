import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';

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
              const _ItemSocial(
                image: "google.svg",
              ),
              SizedBox(width: 12.w),
              const _ItemSocial(
                image: "facebook.png",
              ),
              SizedBox(width: 12.w),
              const _ItemSocial(
                image: "apple.svg",
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
                style:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
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
}

class _ItemSocial extends StatelessWidget {
  final String image;

  const _ItemSocial({required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    ));
  }
}
