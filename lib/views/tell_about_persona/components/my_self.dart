import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MySelfSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MySelfSection({super.key, required this.personaName, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your own name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your age",
          keyboardType: TextInputType.number,
        ),
        AppExpansionTile(
          title: "Select your gender",
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
          description: "Add your personal interests or hobbies",
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any personal challenges you're facing",
        ),
        AppInput(
          prefix: "personality_type.png",
          label: "Personality Type",
          description: "Choose your personality type for self-insight",
        ),
        AppInput(
          prefix: "health.png",
          label: "Health Conditions",
          description: "Include any health conditions for self-care guidance",
        ),
        AppInput(
          prefix: "goals.png",
          label: "Goals",
          description: "Specify personal goals you want to achieve",
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
