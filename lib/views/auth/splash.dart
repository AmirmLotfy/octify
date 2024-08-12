import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';
import 'package:octify/views/auth/on_boarding.dart';

import '../home/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        if (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser!.emailVerified) {
          navigateTo(const HomeView(), keepHistory: false);
        } else {
          navigateTo(
            CacheHelper.isFirstTime
                ? const OnBoardingView()
                : const LoginView(),
            keepHistory: false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Swing(
          child: AppImage(
            "logo.png",
            height: 180.h,
            width: 180.h,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
