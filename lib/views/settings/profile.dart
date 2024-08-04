import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:octify/core/design/app_button.dart';

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
                      source: ImageSource.gallery,
                    );

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
                              : "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
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
              const AppInput(
                label: "First Name",
                prefix: "user_name.svg",
                hint: "Enter First Name",
              ),
              const AppInput(
                label: "Last Name",
                prefix: "user_name.svg",
                hint: "Enter Last Name",
              ),
              const AppInput(
                label: "Email Address",
                prefix: "mail.svg",
                hint: "Enter Email Address",
                keyboardType: TextInputType.emailAddress,
              ),
              const AppInput(
                label: "Phone Number",
                prefix: "phone.svg",
                hint: "Enter Phone Number",
                keyboardType: TextInputType.phone,
              ),
              const AppExpansionTile(
                title: "Select Languages",
                label: "Languages",
                list: [
                  "English (UK)",
                  "Norsk",
                  "Francais",
                ],
                icon: 'select_languages.svg',
              ),
              AppButton(
                onPress: () {},
                text: "Save Changes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
