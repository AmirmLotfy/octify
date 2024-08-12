import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/chat.dart';
import 'package:octify/views/components/item_check_list.dart';
import 'package:octify/views/home/view.dart';
import 'package:octify/views/select_persona.dart';

import '../core/design/second_app_bar.dart';
import 'chat/view.dart';
import 'tell_about_persona/view.dart';

class ResultsView extends StatefulWidget {
  final String title;
  final PersonaType personaType;
  final List<String> challengesList;
  final PersonaModelData personaModelData;

  const ResultsView(
      {super.key,
      required this.title,
      required this.challengesList,
      required this.personaModelData, required this.personaType});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {

  @override
  void initState() {
    super.initState();
    analysis();
  }

  bool isLoading = true;

  String? result;

  void analysis() async {

    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: "AIzaSyCEMn-P4MDyVQYkC_LhtKbq4zm5GKGRqFM");

    late String doctorType;
    switch(widget.personaType)
    {

      case PersonaType.general:
        doctorType= "Psychotherapist";
      case PersonaType.child:
        doctorType= "therapist";
      case PersonaType.partner:
        doctorType= "Psychotherapist";
      case PersonaType.parent:
        doctorType= "Psychotherapist";
      case PersonaType.pet:
        doctorType= "Psychotherapist";
      case PersonaType.friend:
        doctorType= "Psychotherapist";
      case PersonaType.myself:
        doctorType= "Psychotherapist";
      case PersonaType.colleague:
        doctorType= "Psychotherapist";
    }

    String text =
        'Write a curated solution for this persona here are the persona info ${widget.personaModelData.toMap()} and the persona face some challenges like ${widget.challengesList.toString()} and return as html please and act like ${widget.personaType.name} ${doctorType}';
    final content = [
      Content.text(text),
    ];
    final response = await model.generateContent(content);
    debugPrint("*********************");
    debugPrint(text);
    debugPrint("---------------------");
    debugPrint(response.text);
    result = response.text;
    isLoading = false;
    setState(() {});
  }

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
                    text: " to deal with \n ${widget.personaModelData.name}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text(
                      //   "Curated Solutions:",
                      //   style: TextStyle(
                      //       fontSize: 18.sp, fontWeight: FontWeight.w700),
                      // ),
                      //
                      // SizedBox(height: 14.h),
                      if (result != null) ItemCheckList(title: result!),
                      if (result == null)
                        Text(
                          "No Results Found",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: List.generate(
                      //     list.length,
                      //     (index) => Padding(
                      //       padding: EdgeInsets.only(bottom: 14.h),
                      //       child: ItemCheckList(
                      //           title: list[index].title,
                      //           list: list[index].list),
                      //     ),
                      //   ),
                      // )
                    ],
                  )
          ],
        ),
      ),
      bottomNavigationBar: isLoading
          ? SizedBox.shrink()
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      text: "Chat with Octify",
                      onPress: () {
                        navigateTo(ChatView());
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
