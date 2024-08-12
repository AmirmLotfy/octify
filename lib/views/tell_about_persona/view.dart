import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';
import 'package:octify/views/tell_about_persona/components/general.dart';
import 'package:octify/views/tell_about_persona/components/my_colleague.dart';
import 'package:octify/views/tell_about_persona/components/my_partner.dart';

import '../select_persona.dart';
import 'components/my_child.dart';
import 'components/my_friend.dart';
import 'components/my_parent.dart';
import 'components/my_pet.dart';
import 'components/my_self.dart';

class TellAboutPersonaView extends StatefulWidget {
  final String personaName;
  final PersonaType personaType;

  const TellAboutPersonaView(
      {super.key, required this.personaName, required this.personaType});

  @override
  State<TellAboutPersonaView> createState() => _TellAboutPersonaViewState();
}

class _TellAboutPersonaViewState extends State<TellAboutPersonaView> {
  List<int> selectedList = [];

  Widget get form {
    switch (widget.personaType) {
      case PersonaType.general:
        return GeneralSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.child:
        return MyChildSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.partner:
        return MyPartnerSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.parent:
        return MyParentSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.pet:
        return MyPetSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.friend:
        return MyFriendSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.myself:
        return MySelfSection(
            personaName: widget.personaName, type: widget.personaType);
      case PersonaType.colleague:
        return MyColleagueSection(
            personaName: widget.personaName, type: widget.personaType);
    }
  }

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
                      text:
                          "Please provide the following details about the Persona to help us "),
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
            form,
          ],
        ),
      ),
    );
  }
}

class PersonaModelData {
  final String name;
  final String? interestsHobbies,
      sharedInterests,
      gender,
      challenges,
      personalityType,
      healthConditions,
      communicationStyle,
      workRelationship,
      educationLevel,
      petType,
      lifeStage,
      loveLanguage,
      anniversaryDate,
      breed,
      goals,
      favoriteActivities;
  final String? age;

  PersonaModelData({
    required this.name,
    this.gender,
    this.interestsHobbies,
    this.sharedInterests,
    this.petType,
    this.challenges,
    this.personalityType,
    this.healthConditions,
    this.communicationStyle,
    this.workRelationship,
    this.educationLevel,
    this.lifeStage,
    this.loveLanguage,
    this.anniversaryDate,
    this.breed,
    this.goals,
    this.favoriteActivities,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    final data = {
      "name":name,
      "gender":gender,
      "interestsHobbies":interestsHobbies,
      "sharedInterests":sharedInterests,
      "petType":petType,
      "challenges":challenges,
      "personalityType":personalityType,
      "healthConditions":healthConditions,
      "communicationStyle":communicationStyle,
      "workRelationship":workRelationship,
      "educationLevel":educationLevel,
      "lifeStage":lifeStage,
      "loveLanguage":loveLanguage,
      "anniversaryDate":anniversaryDate,
      "breed":breed,
      "goals":goals,
      "favoriteActivities":favoriteActivities,
      "age":age,
    };
    data.removeWhere((key, value) => value==null,);
    return data;
  }
}
