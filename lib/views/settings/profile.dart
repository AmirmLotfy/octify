import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';

import '../../core/design/app_expansion_tile.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import '../../core/design/second_app_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? selectedImage;
  final firstNameController =
      TextEditingController(text: CacheHelper.firstName);
  final lastNameController = TextEditingController(text: CacheHelper.lastName);
  final emailController = TextEditingController(text: CacheHelper.email);
  final phoneController = TextEditingController(text: CacheHelper.phone);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 20);

                    if (image != null) {
                      selectedImage = image.path;
                      setState(() {});
                    }
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.red,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                width: 2.sp),
                            shape: BoxShape.circle),
                        child: AppImage(
                          selectedImage != null
                              ? selectedImage!
                              : CacheHelper.image,
                          height: 80.h,
                          width: 80.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppImage(
                        "profile_image.svg",
                        height: 24.h,
                        width: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              AppInput(
                label: "First Name",
                controller: firstNameController,
                prefix: "user_name.svg",
                hint: "Enter First Name",
              ),
              AppInput(
                label: "Last Name",
                controller: lastNameController,
                prefix: "user_name.svg",
                hint: "Enter Last Name",
              ),
              AbsorbPointer(
                child: Opacity(
                  opacity: .5,
                  child: AppInput(
                    controller: emailController,
                    label: "Email Address",
                    prefix: "mail.svg",
                    hint: "Enter Email Address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              AppInput(
                controller: phoneController,
                label: "Phone Number",
                prefix: "phone.svg",
                hint: "Enter Phone Number",
                keyboardType: TextInputType.phone,
              ),
              // const AppExpansionTile(
              //   title: "Select Languages",
              //   label: "Languages",
              //   list: [
              //     "English (UK)",
              //     "Norsk",
              //     "Francais",
              //   ],
              //   icon: 'select_languages.svg',
              // ),
              AppButton(
                isLoading: isLoading,
                onPress: () async {
                  isLoading = true;
                  setState(() {});
                  String? imageUrl;
                  try {
                    if (selectedImage != null) {
                      final refStorage = FirebaseStorage.instance
                          .ref("users_images")
                          .child(CacheHelper.email);
                      await refStorage.putFile(File(selectedImage!));
                      imageUrl = await refStorage.getDownloadURL();
                    }

                    await FirebaseDatabase.instance
                        .ref()
                        .child("users")
                        .child(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                      {
                        "firstName": firstNameController.text,
                        "lastName": lastNameController.text,
                        "phone": phoneController.text,
                        "email": emailController.text,
                        "image": imageUrl ?? ""
                      },
                    );
                    await CacheHelper.saveUserData(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      image: imageUrl ?? "",
                      phone: phoneController.text,
                      email: emailController.text,
                    );
                    showMessage("Updated Success", type: MessageType.success);
                  } catch (ex) {
                    showMessage(ex.toString());
                  }
                  isLoading = false;
                  setState(() {});
                },
                text: "Save Changes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
