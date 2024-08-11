import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';
import 'package:octify/views/select_persona.dart';

import '../core/design/second_app_bar.dart';
import '../core/theme.dart';

class ChallengesView extends StatefulWidget {
  final String personaName;
  final PersonaType type;

  const ChallengesView({
    super.key,
    required this.personaName,
    required this.type,
  });

  @override
  State<ChallengesView> createState() => _ChallengesViewState();
}

class _ChallengesViewState extends State<ChallengesView> {
  final list = [
    "Communication Issues",
    "Trust Issues",
    "Emotional Support",
    "Conflict Resolution",
    "Time Management",
    "Shared Responsibilities",
    "Lifestyle Differences",
  ];
  List<String> selectedTextsList = [];
  List<int> selectedList = [];
  final otherChallengesController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Challenges"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 2.5.h,
                  fontFamily: AppTheme.fontFamily2,
                ),
                children: [
                  const TextSpan(text: "1. What challenges are you\n"),
                  TextSpan(
                      text: "facing with ${widget.personaName}?",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
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
            SizedBox(height: 32.h),
            AppInput(
              controller: otherChallengesController,
              label: "Other Challenges",
              hint: "Enter Other Challenges",
            )
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Analyze",
        isLoading: isLoading,
        type: ButtonType.bottomNav,
        onPress: () async {
          isLoading = true;
          setState(() {});
          selectedList.forEach(
            (element) {
              selectedTextsList.add(list[element]);
            },
          );
          if (otherChallengesController.text.isNotEmpty) {
            selectedTextsList.add(otherChallengesController.text);
          }
          await Future.delayed(const Duration(seconds: 2));
          isLoading = false;
          setState(() {});
          navigateTo(ResultsView(title: widget.personaName));
        },
      ),
    );
  }
}
