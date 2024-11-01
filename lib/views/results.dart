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
      // case PersonaType.general:
      //   text =
      //       "As a behavioral specialist, suggest strategies for dealing with this persona details this persona not me the persona is someone i face challenges with ${widget.personaModelData.toMap()}. Provide actionable steps to improve interactions and build a more positive relationship.";
      case PersonaType.child:
        text =
            "Acting as a child psychologist, analyze the persona characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}). Provide ${widget.personaModelData.name} with actionable guidance to support the child's needs effectively.";
      case PersonaType.parent:
        text ="As a family counselor, take into account the persona characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}) provided by ${widget.personaModelData.name}. Offer strategies to enhance family dynamics and resolve any issues.";
      case PersonaType.partner:
        text ="As a relationship therapist, use the details from ${widget.personaModelData.toMap()} and the described challenges (${widget.challengesList}) to assist ${widget.personaModelData.name} in developing a stronger and more understanding partnership.";
      case PersonaType.pet:
        text ="Acting as an animal behavior specialist, provide ${widget.personaModelData.name} with a behavior improvement plan that addresses the specific challenges (${widget.challengesList}), using the detailed persona characteristics (${widget.personaModelData.toMap()}).";
      case PersonaType.friend:
        text ="As a life coach, integrate the persona characteristics (${widget.personaModelData.toMap()}) with the challenges (${widget.challengesList}) to guide ${widget.personaModelData.name} in nurturing and strengthening their friendship.";
      case PersonaType.myself:
        text ="Using the input from ${widget.personaModelData.toMap()} and the challenges (${widget.challengesList}), function as a personal development coach to craft a targeted growth and improvement strategy for ${widget.personaModelData.name}.";
      case PersonaType.colleague:
        text ="In your role as a workplace coach, utilize the persona characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}) to help ${widget.personaModelData.name} improve professional interactions and address conflicts.";
      case PersonaType.sibling:
        text ="Utilize your expertise as a family dynamics specialist to analyze ${widget.personaModelData.toMap()} and ${widget.challengesList}. Provide ${widget.personaModelData.name} with a strategic approach to foster a positive sibling relationship.";
      case PersonaType.teenager:
        text ="Act as a youth counselor, taking into account the teenager’s characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}). Offer ${widget.personaModelData.name} strategies to effectively support and connect with the teenager.";
      case PersonaType.baby:
        text ="As a pediatric development specialist, use the persona characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}) to guide ${widget.personaModelData.name} in providing appropriate developmental care for the baby.";
      case PersonaType.neighbor:
        text ="Function as a community relations advisor, using the neighbor's persona characteristics (${widget.personaModelData.toMap()}) and the specific challenges (${widget.challengesList}) to help ${widget.personaModelData.name} maintain harmonious relations.";
      case PersonaType.customer:
        text ="Acting as a customer service expert, apply the customer persona characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}) to aid ${widget.personaModelData.name} in enhancing customer interaction and satisfaction.";
      case PersonaType.teacher:
        text ="As an educational advisor, utilize the teacher’s characteristics (${widget.personaModelData.toMap()}) and the challenges (${widget.challengesList}) to provide ${widget.personaModelData.name} with effective strategies for engaging and collaborating in an educational setting.";
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
                        // case PersonaType.general:
                        //   selectedModel = list[6];
                        //   selectedModel.title = widget.personaModelData.name;
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
