import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyPartnerSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyPartnerSection({super.key, required this.personaName, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your partner's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your partner's age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your partner's gender",
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
          description: "Add your partner's favorite activities or hobbies",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any difficulties your partner may be facing",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description: "Choose your partner's personality type for tailored insights",
        ),
        AppInput(
          prefix: "love_language.png",
          label: "Love Language",
          description: "Select their preferred way of expressing and receiving love",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Choose how your partner prefers to communicate",
        ),
        AppInput(
          prefix: "anniversary.png",
          label: " Anniversary Date",
          description: "Enter the date of your anniversary for important reminders",
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
