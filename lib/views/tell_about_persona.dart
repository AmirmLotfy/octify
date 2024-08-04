import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';

class TellAboutPersonaView extends StatefulWidget {
  final String personaName;

  const TellAboutPersonaView({super.key, required this.personaName});

  @override
  State<TellAboutPersonaView> createState() => _TellAboutPersonaViewState();
}

class _TellAboutPersonaViewState extends State<TellAboutPersonaView> {
  final list = ["Peanuts", "Shellfish", "Pollen", "Pollen", "Hypertension"];
  List<int> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Tell us more about Persona"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  const TextSpan(
                      text: "Please provide the following details to help us "),
                  TextSpan(
                    text: "understand your needs better.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            const AppInput(
              prefix: "user_name.svg",
              label: "First Name",
              hint: "Enter First Name",
            ),
            const AppInput(
              prefix: "age.svg",
              label: "Age",
              hint: "Enter Age",
              keyboardType: TextInputType.number,
            ),
            const AppExpansionTile(
              title: "Select Gender",
              label: "Gender",
              list: [
                "Male",
                "Female",
                "Other",
                "Prefer not to say",
              ],
              icon: 'gender.svg',
            ),
            // const AppExpansionTile(
            //   title: "Select Blood Type",
            //   label: "Blood Group",
            //   list: [
            //     "A",
            //     "B",
            //     "AB",
            //     "O",
            //   ],
            //   icon: 'blood_type.svg',
            // ),
            SizedBox(height: 16.h),
            Text(
              "Allergies",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 16.w,
              runSpacing: 16.h,
              children: List.generate(
                list.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (selectedList.contains(index)) {
                      selectedList.remove(index);
                    } else {
                      selectedList.add(index);
                    }

                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 27.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                        color: selectedList.contains(index)
                            ? Theme.of(context).primaryColor
                            : null,
                        border: !selectedList.contains(index)
                            ? Border.all(
                                color: Theme.of(context).dividerColor,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: selectedList.contains(index)
                            ? Colors.white
                            : const Color(0xff8c8c8c),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            TextFormField(
              minLines: 3,
              maxLines: 7,
              decoration: const InputDecoration(
                  hintText: "Medical/Mental Health Issues"),
            ),
            SizedBox(height: 24.h),
            AppButton(
              text: "Next",
              onPress: () {
                navigateTo(ChallengesView(personaName: widget.personaName,));
              },
            )
          ],
        ),
      ),
    );
  }
}
