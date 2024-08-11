import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyColleagueSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyColleagueSection({super.key, required this.personaName, required this.type});
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your colleague's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your colleague's age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your colleague's gender",
          label: "Gender",
          list: [
            "Male",
            "Female",
            "Other",
            "Prefer not to say",
          ],
          icon: 'gender.svg',
        ),
        AppInput(
          prefix: "interests.png",
          label: "Interests/Hobbies",
          description: "Add your colleague's professional interests or hobbies",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any workplace challenges you both face",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description: "Choose your colleague's personality type",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Choose how your colleague prefers to communicate",
        ),
        AppInput(
          prefix: "work_relationship.png",
          label: " Work Relationship",
          description: "Define the nature of your professional relationship (e.g., peer, supervisor).",
        ),
        AppButton(
          text: "Next",
          onPress: () {
            navigateTo(ChallengesView(personaName: personaName,type: type,));
          },
        )
      ],
    );
  }
}
