import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/dialogs/logout.dart';
import 'package:octify/views/settings/help.dart';
import 'package:octify/views/settings/notifications.dart';
import 'package:octify/views/settings/privacy.dart';
import 'package:octify/views/settings/profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const AppBack(),
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            _Item(
                text: "Profile",
                image: "profile.svg",
                onPress: () {
                  navigateTo(const ProfileView());
                }),
            _Item(
                text: "Notification",
                image: "notification.svg",
                onPress: () {
                  navigateTo(const NotificationsView());
                }),
            _Item(
                text: "Data privacy and usage",
                image: "data_privacy_and_usage.svg",
                onPress: () {
                  navigateTo(const PrivacyView());
                }),
            _Item(
                text: "Help and support",
                image: "help_and_support.svg",
                onPress: () {
                  navigateTo(const HelpView());
                }),
            // todo: make delete account
            // todo: wait for rate us item to made in UI
            _Item(
                text: "Logout",
                image: "logout.svg",
                withDivider: false,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LogoutDialog(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String image, text;
  final bool withDivider;
  final VoidCallback onPress;

  const _Item({
    required this.image,
    required this.text,
    required this.onPress,
    this.withDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  AppImage(
                    image,
                    height: 32.h,
                    width: 32.h,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                      child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  SizedBox(width: 12.w),
                  AppImage(
                    "arrow_right.svg",
                    height: 20.h,
                    width: 20.h,
                  )
                ],
              ),
              SizedBox(height: 12.w),
              if (withDivider) const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
