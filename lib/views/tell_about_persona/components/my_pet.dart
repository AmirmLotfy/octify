import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyPetSection extends StatelessWidget {
  final String personaName;
  final PersonaType type;

  const MyPetSection({super.key, required this.personaName, required this.type});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInput(
          prefix: "user_name.svg",
          label: " Name",
          description: "Enter your pet's name",
        ),
        AppInput(
          prefix: "age.svg",
          label: "Age",
          description: "Specify your pet's age",
          keyboardType: TextInputType.number,
        ),
        AppInput(
          prefix: "pet_type.png",
          label: "Type",
          description: "Select the type of pet (e.g., dog, cat)",
        ),
        AppInput(
          prefix: "breed.png",
          label: "Breed",
          description: "Enter your pet's breed if known",
        ),
        AppInput(
          prefix: "health.png",
          label: "Health Conditions",
          description: "Include any health conditions for better care advice",
        ),
        AppInput(
          prefix: "favorite_activities.png",
          label: " Favorite Activities",
          description: "List activities your pet enjoys most",
          keyboardType: TextInputType.number,
        ),
        AppInput(
          prefix: "challenges.png",
          label: "Challenges",
          description: "List any behavioral or health challenges your pet may have.",
        ),
        AppInput(
          prefix: "communication_style.png",
          label: "Communication Style",
          description: "Describe how your pet communicates or responds to you",
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
