import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/login.dart';

import '../../core/logic/cache_helper.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  bool isLoading = false;
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(24.r),
      children: [
        Text(
          "Are You Sure You Want To\nDelete Your Account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        AppImage(
          "delete_account.svg",
          height: 62.h,
          width: 62.h,
          fit: BoxFit.fitHeight,
        ),
        AppInput(
          label: "Password",
          onChanged: (value) {
            setState(() {});
          },
          hint: "Enter Your Password to Confirm",
          controller: passwordController,
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                isLoading: isLoading,
                onPress: passwordController.text.isNotEmpty
                    ? () async {
                        isLoading = true;
                        setState(() {});

                        try {
                          await FirebaseAuth.instance.currentUser!
                              .reauthenticateWithCredential(
                                  EmailAuthProvider.credential(
                            email: CacheHelper.email,
                            password: passwordController.text,
                          ));
                          String uid= FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseDatabase.instance
                              .ref()
                              .child("users")
                              .child(uid).remove();
                          await FirebaseAuth.instance.currentUser!.delete();


                          if (CacheHelper.image.isNotEmpty) {
                            final refStorage = FirebaseStorage.instance
                                .ref("users_images")
                                .child(CacheHelper.email);
                            await refStorage.delete();
                          }
                          await CacheHelper.logOut();
                          navigateTo(const LoginView(), keepHistory: false);
                          showMessage("Your account has deleted Success",
                              type: MessageType.success);
                        } on FirebaseAuthException catch (ex) {
                          Navigator.pop(context);
                          showMessage(ex.code);
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    : null,
                text: "Yes! Delete",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
