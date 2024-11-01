import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';
import 'package:octify/views/tell_about_persona/components/baby.dart';
import 'package:octify/views/tell_about_persona/components/customer.dart';
import 'package:octify/views/tell_about_persona/components/general.dart';
import 'package:octify/views/tell_about_persona/components/my_colleague.dart';
import 'package:octify/views/tell_about_persona/components/my_partner.dart';
import 'package:octify/views/tell_about_persona/components/neighbor.dart';
import 'package:octify/views/tell_about_persona/components/sibling.dart';
import 'package:octify/views/tell_about_persona/components/teacher.dart';
import 'package:octify/views/tell_about_persona/components/teenager.dart';

import '../select_persona.dart';
import 'components/my_child.dart';
import 'components/my_friend.dart';
import 'components/my_parent.dart';
import 'components/my_pet.dart';
import 'components/my_self.dart';

class TellAboutPersonaView extends StatefulWidget {
  final PersonaType personaType;

  const TellAboutPersonaView({super.key, required this.personaType});

  @override
  State<TellAboutPersonaView> createState() => _TellAboutPersonaViewState();
}

class _TellAboutPersonaViewState extends State<TellAboutPersonaView> {
  List<int> selectedList = [];

  Widget get form {
    switch (widget.personaType) {
      // case PersonaType.general:
      //   return GeneralSection(type: widget.personaType);
      case PersonaType.child:
        return MyChildSection(type: widget.personaType);
      case PersonaType.partner:
        return MyPartnerSection(type: widget.personaType);
      case PersonaType.parent:
        return MyParentSection(type: widget.personaType);
      case PersonaType.pet:
        return MyPetSection(type: widget.personaType);
      case PersonaType.friend:
        return MyFriendSection(type: widget.personaType);
      case PersonaType.myself:
        return MySelfSection(type: widget.personaType);
      case PersonaType.colleague:
        return MyColleagueSection(type: widget.personaType);
      case PersonaType.sibling:
        return SiblingSection(type: widget.personaType);
      case PersonaType.teenager:
        return TeenagerSection(type: widget.personaType);
      case PersonaType.baby:
        return BabySection(type: widget.personaType);
      case PersonaType.neighbor:
        return NeighborSection(type: widget.personaType);
      case PersonaType.customer:
        return CustomerSection(type: widget.personaType);
      case PersonaType.teacher:
        return TeacherSection(type: widget.personaType);
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
                          "Please provide the following\ndetails to help us "),
                  TextSpan(
                    text: "understand\nyour needs better.",
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
  late final String name;
  late final PersonaType type;
  late final String? interestsHobbies,
      sharedInterests,
      gender,
      relationship,
      occupation,
      challenges,
      purchaseHistory,
      liveSituation,
      preferredCommunicationMethod,
      friendshipDuration,
      personalityType,
      healthConcerns,
      communicationStyle,
      workRelationship,
      species,
      educationLevel,
      relationStatus,
      petType,
      lifeStage,
      department,
      loveLanguage,
      liveTogether,
      sharedCommunityInterests,
      friendshipType,
      anniversaryDate,
      breed,
      studentAgeGroup,
      birthOrder,
      friendGroup,
      currentFocus,
      teachingStyle,
      developmentalMilestones,
      position,
      favoriteTreats,
      subjectTaught,
      sleepSchedule,
      currentSchoolYear,
      frequencyOfInteraction,
      goals,
      favoriteActivities;
  late final String? age;

  PersonaModelData.fromJson(Map<String, dynamic> json) {
    age = json['age'] ?? "0";
    communicationStyle = json['communicationStyle'] ?? "";
    gender = json['gender'] ?? "";
    interestsHobbies = json['interestsHobbies'] ?? "";
    name = json['name'] ?? "";
    occupation = json['occupation'] ?? "";
    relationship = json['relationship'] ?? "";
    personalityType = json['personalityType'] ?? "";
    workRelationship = json['workRelationship'] ?? "";
    studentAgeGroup = json['studentAgeGroup'] ?? "";
    sharedInterests = json['sharedInterests'] ?? "";
    petType = json['petType'] ?? "";
    challenges = json['challenges'] ?? "";
    healthConcerns = json['healthConcerns'] ?? "";
    educationLevel = json['educationLevel'] ?? "";
    lifeStage = json['lifeStage'] ?? "";
    loveLanguage = json['loveLanguage'] ?? "";
    currentFocus = json['currentFocus'] ?? "";
    liveSituation = json['liveSituation'] ?? "";
    liveTogether = json['liveTogether'] ?? "";
    favoriteTreats = json['favoriteTreats'] ?? "";
    anniversaryDate = json['anniversaryDate'] ?? "";
    developmentalMilestones = json['developmentalMilestones'] ?? "";
    subjectTaught = json['subjectTaught'] ?? "";
    breed = json['breed'] ?? "";
    goals = json['goals'] ?? "";
    position = json['position'] ?? "";
    department = json['department'] ?? "";
    relationStatus = json['relationStatus'] ?? "";
    teachingStyle = json['teachingStyle'] ?? "";
    species = json['species'] ?? "";
    birthOrder = json['birthOrder'] ?? "";
    friendshipType = json['friendshipType'] ?? "";
    favoriteActivities = json['favoriteActivities'] ?? "";
    currentSchoolYear = json['currentSchoolYear'] ?? "";
    friendGroup = json['friendGroup'] ?? "";
    preferredCommunicationMethod = json['preferredCommunicationMethod'] ?? "";
    sleepSchedule = json['sleepSchedule'] ?? "";
    sharedCommunityInterests = json['sharedCommunityInterests'] ?? "";
    frequencyOfInteraction = json['frequencyOfInteraction'] ?? "";
    friendshipDuration = json['friendshipDuration'] ?? "";
    currentFocus = json['currentFocus'] ?? "";
    purchaseHistory = json['purchaseHistory'] ?? "";
    String myType = json["personaType"] ?? "";
    type = PersonaType.values
        .where(
          (element) => element.name == myType,
        )
        .first;
    print(type);
  }

  PersonaModelData({
    required this.name,
    this.gender,
    this.currentFocus,
    this.species,
    this.subjectTaught,
    this.studentAgeGroup,
    this.purchaseHistory,
    this.sleepSchedule,
    this.teachingStyle,
    this.sharedCommunityInterests,
    this.friendGroup,
    this.preferredCommunicationMethod,
    this.developmentalMilestones,
    this.birthOrder,
    this.friendshipDuration,
    this.currentSchoolYear,
    this.friendshipType,
    this.frequencyOfInteraction,
    this.department,
    this.position,
    this.liveTogether,
    this.interestsHobbies,
    this.sharedInterests,
    this.petType,
    this.challenges,
    this.personalityType,
    this.healthConcerns,
    this.communicationStyle,
    this.workRelationship,
    this.occupation,
    this.educationLevel,
    this.lifeStage,
    this.loveLanguage,
    this.anniversaryDate,
    this.relationship,
    this.liveSituation,
    this.relationStatus,
    this.favoriteTreats,
    this.breed,
    this.goals,
    required this.type,
    this.favoriteActivities,
    this.age,
  });

  Map<String, dynamic> toMap() {
    final data = {
      "name": name,
      "gender": gender,
      "interestsHobbies": interestsHobbies,
      "sharedInterests": sharedInterests,
      "petType": petType,
      "friendshipDuration": friendshipDuration,
      "challenges": challenges,
      "friendshipType": friendshipType,
      "personalityType": personalityType,
      "healthConcerns": healthConcerns,
      "communicationStyle": communicationStyle,
      "species": species,
      "workRelationship": workRelationship,
      "educationLevel": educationLevel,
      "birthOrder": birthOrder,
      "friendGroup": friendGroup,
      "liveSituation": liveSituation,
      "occupation": occupation,
      "studentAgeGroup": studentAgeGroup,
      "lifeStage": lifeStage,
      "sleepSchedule": sleepSchedule,
      "currentSchoolYear": currentSchoolYear,
      "loveLanguage": loveLanguage,
      "anniversaryDate": anniversaryDate,
      "breed": breed,
      "frequencyOfInteraction": frequencyOfInteraction,
      "developmentalMilestones": developmentalMilestones,
      "preferredCommunicationMethod": preferredCommunicationMethod,
      "currentFocus": currentFocus,
      "subjectTaught": subjectTaught,
      "favoriteTreats": favoriteTreats,
      "teachingStyle": teachingStyle,
      "goals": goals,
      "sharedCommunityInterests": sharedCommunityInterests,
      "favoriteActivities": favoriteActivities,
      "age": age,
      "relationship": relationship,
      "purchaseHistory": purchaseHistory,
      "personaType": type.name,
    };
    data.removeWhere(
      (key, value) => value == null,
    );
    return data;
  }
}
