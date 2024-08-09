import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';

enum PersonaType {general,child,partner,parent,pet,friend,myself,colleague}

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
            // todo add icon for grade
            const AppInput(
              prefix: "",
              label: "School Grade",
              hint: "Enter Grade",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Relationship with this persona",
              hint: "",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Health Conditions",
              hint: "Health Conditions",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Behavioral Traits",
              hint: "Enter your behavioral traits",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Interests/Hobbies",
              hint: "Enter your interests hobbies",
              keyboardType: TextInputType.number,
            ),
            const AppExpansionTile(
              title: "Select",
              label: "Academic Performance",
              list: [
                "Very Bad",
                "Bad",
                "Neutral",
                "Good",
                "Very Good",
              ],
              icon: '',
            ),
            const AppInput(
              prefix: "",
              label: "Social Relationships",
              hint: "Enter your social relationships",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Occupation",
              hint: "Enter your occupation",
              keyboardType: TextInputType.number,
            ),
            // todo: make it like the comment months and years
            const AppInput(
              prefix: "",
              label: "Relationship Duration",
              hint: "MM/YY",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Communication Style",
              hint: "Enter your communication style",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Life Goals",
              hint: "Enter your Life Goals",
            ),
            // todo: make add button and clickable to show sheet
            // in the sheet he enter the name of the date and select the date
            // from calendat and then press save and it shown below the item
            // he also can delete or edit it when click on it
            const AppInput(
              prefix: "",
              label: "Important Dates",
              hint: "Enter your important dates",
              keyboardType: TextInputType.number,
            ),
            const AppInput(
              prefix: "",
              label: "Living Situation",
              hint: "Ex: alone, with family",
            ),
            const AppInput(
              prefix: "",
              label: "Support Needs",
              hint: "Ex: alone, with family",
            ),
            const AppInput(
              prefix: "",
              label: "Emotional State",
              hint: "Ex: loneliness, happiness",
            ),
            // todo: they will give me description for every input or choose
            // and you will add info icon clickable to show tooltip description
            const AppInput(
              prefix: "",
              label: "Personal Goals",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Support System",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Species/Breed",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Diet",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Exercise Needs",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Favorite Activities",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Position",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Department",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Work Style",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Project Involvement",
              hint: "",
            ),
            const AppInput(
              prefix: "",
              label: "Professional Goals",
              hint: "",
            ),
            // todo: they will see if they need it
            // const AppInput(
            //   prefix: "",
            //   label: "Current Life Situation",
            //   hint: "Ex: ",
            // ),
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
