import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';

import '../core/design/second_app_bar.dart';
import '../core/theme.dart';

class ChallengesView extends StatefulWidget {
  final String personaName;
  const ChallengesView({super.key, required this.personaName});

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

  int? selectedIndex;
  //todo: make it multi select and can also write challenge
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
                    selectedIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 27.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Theme.of(context).primaryColor
                            : null,
                        border: selectedIndex != index
                            ? Border.all(
                                color: Theme.of(context).dividerColor,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: selectedIndex == index
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
              label: "Other Challenges",
              hint: "Enter Other Challenges",
              onChanged: (value) {
                selectedIndex = null;
                setState(() {});
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Analyze",
        type: ButtonType.bottomNav,
        onPress: () {
          navigateTo(ResultsView(title: widget.personaName));
        },
      ),
    );
  }
}
