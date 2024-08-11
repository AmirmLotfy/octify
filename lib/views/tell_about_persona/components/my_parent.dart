import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyParentSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyParentSection({super.key, required this.personaName, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your parent's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your parent's age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your parent's gender",
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
          description: "Add your parent's hobbies or favorite activities",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any challenges your parent may be facing",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description: "Choose your parent's personality type",
        ),
        AppInput(
          prefix: "health.png",
          label: "Health Conditions",
          description: "Include any health conditions for better guidance",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Select how your parent prefers to communicate",
        ),
        AppInput(
          prefix: "life_stage.png",
          label: "Life Stage",
          description: "Indicate their current life stage (e.g., retirement)",
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
