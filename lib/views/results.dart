import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/chat.dart';
import 'package:octify/views/components/item_check_list.dart';
import 'package:octify/views/home/view.dart';
import 'package:octify/views/select_persona.dart';

import '../core/design/second_app_bar.dart';
import 'chat/view.dart';
import 'home/pages/home.dart';
import 'tell_about_persona/view.dart';

class ResultsView extends StatefulWidget {
  final String title;
  final String? result;
  final PersonaType personaType;
  final List<String> challengesList;
  final PersonaModelData personaModelData;

  const ResultsView(
      {super.key,
      required this.title,
      this.result,
      required this.challengesList,
      required this.personaModelData,
      required this.personaType});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  @override
  void initState() {
    super.initState();
    if (widget.result == null) {
      analysis();
    } else {
      isLoading = false;
      result = widget.result;
    }
  }

  bool isLoading = true;
  bool isSaveLoading = false;

  String? result;

  void analysis() async {
    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: "AIzaSyCEMn-P4MDyVQYkC_LhtKbq4zm5GKGRqFM");

    late String text;
    switch (widget.personaType) {
      case PersonaType.general:
        text =
            "As a behavioral specialist, suggest strategies for dealing with this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Provide actionable steps to improve interactions and build a more positive relationship.";
      case PersonaType.child:
        text =
            "As a child psychologist, provide expert advice on how to manage this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}, including step-by-step actions to improve their behavior and support their emotional development.";
      case PersonaType.partner:
        text =
            "As a relationship counselor, offer advice on how to improve my relationship with my partner, especially in dealing with this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Provide a step-by-step plan to deepen our emotional connection and resolve conflicts.";
      case PersonaType.parent:
        text =
            "As a family therapist, offer guidance on improving the relationship with my parent, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include a step-by-step action plan to foster mutual understanding and respect";
      case PersonaType.pet:
        text =
            "As a pet behaviorist, provide advice on managing this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include a step-by-step plan to improve my pet’s behavior and strengthen our bond.";
      case PersonaType.friend:
        text =
            "As a life coach, suggest ways to strengthen my friendship with ${widget.personaModelData.name}, particularly in dealing with this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Provide actionable steps to enhance our connection and support each other better.";
      case PersonaType.myself:
        text =
            "As a personal development coach, guide me on how to address this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Offer a detailed action plan to help me improve and achieve my personal goals.";
      case PersonaType.colleague:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      // todo: change these to real
      case PersonaType.sibling:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      case PersonaType.teenager:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      case PersonaType.baby:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      case PersonaType.neighbor:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      case PersonaType.customer:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
      case PersonaType.teacher:
        text =
            "As a workplace coach, provide advice on how to improve my professional relationship with ${widget.personaModelData.name}, focusing on this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Include practical steps to enhance teamwork and resolve conflicts.";
    }

    // String text =
    //     'Write a curated solution for this persona  this persona is not me here are the persona info ${widget.personaModelData.toMap()} and the persona face some challenges like ${widget.challengesList.toString()} and return as html please and act like ${widget.personaType.name} ${doctorType}';
    final content = [
      Content.text(text +
          " and please don't show conclusion section or resources or links"),
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

  List<HistoryModel> list = [
    HistoryModel(
      icon: "child_fill.svg",
      title: "My Child",
      body:
          "Track your child's developmental milestones, challenges, and achievements. View past advice and insights tailored to their growth.",
      bgShape: "shape1.svg",
      color: 0xffA6B2EE,
    ),
    HistoryModel(
      icon: "partner_filled.svg",
      title: "My Partner",
      body:
          "Review your relationship history, past advice, and personalized insights. Monitor key moments and challenges faced together.",
      bgShape: "shape2.svg",
      color: 0xff8FD1CD,
    ),
    HistoryModel(
      icon: "parent_fill.svg",
      title: "My Parent",
      body:
          "Keep a record of your parent's health updates, caregiving tips, and relationship advice. Access previous guidance tailored to their needs.",
      bgShape: "shape3.svg",
      color: 0xff7FD2F2,
    ),
    HistoryModel(
        icon: "friend_filled.svg",
        title: "My Friend",
        body:
            "Maintain a history of your friend's important events, interests, and challenges. Revisit past advice to strengthen your friendship.",
        bgShape: "shape4.svg",
        color: 0xffFEDEA5),
    HistoryModel(
        icon: "my_self_fill.svg",
        title: "Myself",
        body:
            "View your personal growth journey, self-care plans, and past advice. Reflect on your progress and revisit previous recommendations.",
        bgShape: "shape1.svg",
        color: 0xffEBCAE7),
    HistoryModel(
        icon: "my_pet_fill.svg",
        title: "My Pet",
        body:
            "Record your pet’s health updates, care tips, and special moments. Access past advice to ensure your pet’s well-being.",
        bgShape: "shape2.svg",
        color: 0xffC2D6FE),
    HistoryModel(
        icon: "colleague_filled.svg",
        title: "My Colleague",
        body:
            "Monitor key interactions, professional challenges, and milestones with your colleague. Access past advice to improve workplace relationships and collaboration.",
        bgShape: "shape3.svg",
        color: 0xff96D9B0),
    HistoryModel(
        icon: "general.svg",
        title: "",
        body: "This is custom persona",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Sibling",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Teenager",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Baby",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Neighbor",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Customer",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
    HistoryModel(
        icon: "",
        title: "Teacher",
        body: "",
        bgShape: "shape3.svg",
        color: 0xff49d56d),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(
        text: "Results and Solutions",
        actions: [
          if (!isLoading && widget.result == null)
            isSaveLoading
                ? Padding(
                    padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      // save result
                      // save selected Challenges
                      // save persona model
                      HistoryModel selectedModel;
                      switch (widget.personaType) {
                        case PersonaType.general:
                          selectedModel = list[6];
                          selectedModel.title = widget.personaModelData.name;
                        case PersonaType.child:
                          selectedModel = list[0];
                        case PersonaType.partner:
                          selectedModel = list[1];
                        case PersonaType.parent:
                          selectedModel = list[2];
                        case PersonaType.pet:
                          selectedModel = list[5];
                        case PersonaType.friend:
                          selectedModel = list[3];
                        case PersonaType.myself:
                          selectedModel = list[4];
                        case PersonaType.colleague:
                          selectedModel = list[6];
                        case PersonaType.sibling:
                          selectedModel = list[8];
                        case PersonaType.teenager:
                          selectedModel = list[9];
                        case PersonaType.baby:
                          selectedModel = list[10];
                        case PersonaType.neighbor:
                          selectedModel = list[11];
                        case PersonaType.customer:
                          selectedModel = list[12];
                        case PersonaType.teacher:
                          selectedModel = list[13];
                      }

                      isSaveLoading = true;
                      setState(() {});
                      await FirebaseDatabase.instance
                          .ref()
                          .child("home")
                          .child(FirebaseAuth.instance.currentUser!.uid)
                          .push()
                          .set({
                        "result": result,
                        "personaShape": selectedModel.toMap(),
                        "selectedChallenges": widget.challengesList,
                        "personaModel": widget.personaModelData.toMap(),
                      });
                      isSaveLoading = false;
                      setState(() {});
                      showMessage("Persona Saved Successfully",
                          type: MessageType.success);
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.save,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  )
        ],
      ),
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
