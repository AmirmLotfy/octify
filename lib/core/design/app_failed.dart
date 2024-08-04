
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_button.dart';
import 'app_image.dart';

class AppFailed extends StatelessWidget {
  final int? statusCode;
  final VoidCallback onPress;
  final String msg;
  final bool isScrollable;
  final String? description;

  const AppFailed({
    super.key,
    this.statusCode,
    required this.msg,
    required this.onPress,
    this.description,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: AppImage(
                msg.toLowerCase().contains("no internet") ? "no_internet.png" : "server_error.jpg",
                height: 240.h,
                width: 240.h,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  // color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            if (description != null || msg.toLowerCase().contains("no internet"))
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Text(
                  description ?? "No Internet connection found. Check\nyour connection or try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppButton(
                text: "Try Again",
                onPress: onPress,
              ),
            )
          ],
        ),
      ),
    );
  }
}
