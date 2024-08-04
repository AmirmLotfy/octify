import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/chat.dart';
import 'package:octify/views/components/item_check_list.dart';
import 'package:octify/views/home/view.dart';

import '../core/design/second_app_bar.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final list = [
    _Model(
      title: "Solution 1: Improve Communication",
      list: [
        "Schedule weekly check-ins to discuss concerns and achievements.",
        "Use active listening techniques during conversations.",
        "Set clear and respectful communication boundaries.",
      ],
    ),
    _Model(
      title: "Solution 2: Build Trust",
      list: [
        "Be consistent with actions and words.",
        "Share feelings and thoughts honestly.",
        "Create and honor mutual agreements.",
      ],
    ),
    _Model(
      title: "Solution 3: Manage Conflicts",
      list: [
        "Identify the root cause of conflicts calmly.",
        "Use “I” statements to express feelings without blaming.",
        "Seek compromise and find mutually acceptable solutions.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Results and Solutions"),
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
                    fontFamily: AppTheme.fontFamily2),
                children: [
                  const TextSpan(text: "Suggested Solutions"),
                  TextSpan(
                      text: " for\n[Persona]",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            Text(
              "Curated Solutions:",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 14.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                list.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: ItemCheckList(
                      title: list[index].title, list: list[index].list),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                text: "Chat with Octify",
                onPress: () {
                  navigateTo(const ChatView());
                },
              ),
              AppButton(
                text: "Go to Home",
                type: ButtonType.outlined,
                onPress: () {
                  navigateTo(const HomeView(), keepHistory: false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Model {
  final String title;
  final List<String> list;

  _Model({required this.title, required this.list});
}
