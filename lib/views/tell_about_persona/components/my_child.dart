import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyChildSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyChildSection({super.key, required this.personaName, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your child's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your child's age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your child's gender",
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
          description: "Add your child's hobbies or passions",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any difficulties your child may be facing",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description:
              "Choose a personality type to better understand your child",
        ),
        AppInput(
          prefix: "health.png",
          label: "Health Conditions",
          description: "Include any relevant health conditions",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Select how your child prefers to communicate",
        ),
        AppInput(
          prefix: "education.png",
          label: "Education Level",
          description:
              "Indicate your child's current grade or educational stage",
          keyboardType: TextInputType.number,
        ),
        AppInput(
          prefix: "favorite_activities.png",
          label: " Favorite Activities",
          description: "List activities your child enjoys most",
          keyboardType: TextInputType.number,
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
