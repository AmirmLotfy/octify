import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyFriendSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyFriendSection({super.key, required this.personaName, required this.type});
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your friend's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your friend's age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your friend's gender",
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
          description: "Add your friend's hobbies or favorite pastimes",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any challenges your friend may be dealing with",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description: "Choose your friend's personality type",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Select how your friend prefers to communicate",
        ),
        AppInput(
          prefix: "interests.png",
          label: "Shared Interests",
          description: "List activities or interests you both enjoy",
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
