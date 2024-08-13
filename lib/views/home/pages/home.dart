import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';

import '../../all_history.dart';
import '../../select_persona.dart';
import '../../tell_about_persona/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  // todo show user image if founded else show the first char of his name
                  if (CacheHelper.image.isEmpty &&
                      CacheHelper.firstName.isNotEmpty)
                    Container(
                      height: 48.h,
                      width: 48.h,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffEEEEEE),
                          )),
                      child: Text(
                        CacheHelper.firstName[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  if (CacheHelper.image.isNotEmpty)
                    ClipOval(
                      child: AppImage(
                        CacheHelper.image,
                        height: 48.h,
                        fit: BoxFit.cover,
                        width: 48.h,
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        CacheHelper.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance
            .ref()
            .child("home")
            .child(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HomeDataModel model;
            if (snapshot.data!.value == null) {
              model = HomeDataModel(list: []);
            } else {
              final data = json.encode(snapshot.data!.value);
              model = HomeDataModel.fromJson(json.decode(data));
            }
            return Padding(
              padding: const EdgeInsets.all(24).copyWith(top: 8.h),
              child: Column(
                children: [
                  if (model.list.length > 4)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(AllHistoryView(list: model.list));
                              },
                              child: const Text("View All"))
                        ],
                      ),
                    ),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (model.list.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(24.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppImage("create_persona.svg"),
                              Text(
                                "Create a unique persona to tailor solutions\nthat perfectly align with your needs.",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Theme.of(context).hintColor),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 32.h),
                              FilledButton.icon(
                                icon: const AppImage("add.svg"),
                                onPressed: () {
                                  navigateTo(SelectPersonaView());
                                },
                                label: const Text("Create Persona"),
                              )
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        // padding: EdgeInsets.all(24.r),
                        itemBuilder: (context, index) =>
                            ItemHistory(model: model.list[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.5.h),
                        itemCount:
                            model.list.length > 4 ? 4 : model.list.length,
                      );
                    }),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to load data"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class HistoryModel {
  late String icon, body, bgShape;
  late String title;
  late int color;

  HistoryModel(
      {required this.icon,
      required this.title,
      required this.body,
      required this.bgShape,
      required this.color});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    bgShape = json['bgShape'] ?? "";
    body = json['body'] ?? "";
    color = json['color'] ?? 0xffffffff;
    icon = json['icon'] ?? "";
    title = json['title'] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      "icon": icon,
      "title": title,
      "body": body,
      "bgShape": bgShape,
      "color": color,
    };
  }
}

class ItemHistory extends StatelessWidget {
  final HomeData model;

  const ItemHistory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        // todo: it suppose that you will save the result that gemini ai return with the persona in firebase
        navigateTo(ResultsView(
          title: "",
          result: model.result,
          personaType: model.personaModel.type,
          personaModelData: model.personaModel,
          challengesList: model.selectedChallenges,
        ));
      },
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color(model.personaShape.color),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppImage(
                model.personaShape.bgShape,
                height: 132.h,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AppImage(
                          model.personaShape.icon,
                          height: 48.h,
                          width: 48.h,
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          model.personaShape.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      model.personaShape.body,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDataModel {
  late final List<HomeData> list;

  HomeDataModel({required this.list});

  HomeDataModel.fromJson(Map<dynamic, dynamic> json) {
    list = [];
    json.forEach(
      (key, value) {
        list.add(HomeData.fromJson(value));
      },
    );
  }
}

class HomeData {
  late final PersonaModelData personaModel;
  late final HistoryModel personaShape;
  late final String result;
  late final List<String> selectedChallenges;

  HomeData.fromJson(Map<String, dynamic> json) {
    personaModel = PersonaModelData.fromJson(json['personaModel'] ?? {});
    personaShape = HistoryModel.fromJson(json['personaShape'] ?? {});
    result = json['result'] ?? "";
    selectedChallenges =
        List.castFrom<dynamic, String>(json['selectedChallenges'] ?? []);
  }
}

// class PersonaModel {
//   late final String age;
//   late final String communicationStyle;
//   late final String gender;
//   late final String interestsHobbies;
//   late final String name;
//   late final String personalityType;
//   late final String workRelationship;
//
//   PersonaModel.fromJson(Map<String, dynamic> json) {
//     age = json['age'] ?? 0;
//     communicationStyle = json['communicationStyle'] ?? "";
//     gender = json['gender'] ?? "";
//     interestsHobbies = json['interestsHobbies'] ?? "";
//     name = json['name'] ?? "";
//     personalityType = json['personalityType'] ?? "";
//     workRelationship = json['workRelationship'] ?? "";
//   }
// }
