import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MyPetSection extends StatefulWidget {
  final String personaName;
  final PersonaType type;

  const MyPetSection(
      {super.key, required this.personaName, required this.type});

  @override
  State<MyPetSection> createState() => _MyPetSectionState();
}

class _MyPetSectionState extends State<MyPetSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final challengesController = TextEditingController();
  final healthController = TextEditingController();
  final favoriteActivitiesController = TextEditingController();
  final petTypeController = TextEditingController();
  final breedController = TextEditingController();
  final communicationStyleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInput(
            prefix: "user_name.svg",
            label: " Name",
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            hint: "Enter your pet's name",
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",            validator: InputValidator.personaAgeValidator,

            controller: ageController,
            hint: "Specify your pet's age",
            keyboardType: TextInputType.number,
          ),
          AppInput(
            prefix: "pet_type.png",
            label: "Type",
            hint: "Enter Pet Type",
            controller: petTypeController,
            validator: InputValidator.personaPetTypeValidator,
            description: "Select the type of pet (e.g., dog, cat)",
          ),
          AppInput(
            prefix: "breed.png",
            label: "Breed",
            hint: "Enter Breed",
            controller: breedController,
            validator: InputValidator.personaBreedValidator,
            description: "Enter your pet's breed if known",
          ),
          AppInput(
            prefix: "health.png",
            controller: healthController,
            label: "Health Conditions",
            validator: InputValidator.personaHealthConditionsValidator,
            hint: "Enter Health Conditions",
            description: "Include any health conditions for better care advice",
          ),
          AppInput(
            prefix: "favorite_activities.png",
            label: "Favorite Activities",
            validator: InputValidator.personaFavoriteActivitiesValidator,
            hint: "Enter Favorite Activities",
            controller: favoriteActivitiesController,
            description: "List activities your pet enjoys most",
            keyboardType: TextInputType.number,
          ),
          AppInput(
            prefix: "challenges.png",
            label: "Challenges",
            validator: InputValidator.personaChallengesValidator,
            hint: "Enter Challenges",
            controller: challengesController,
            description:
                "List any behavioral or health challenges your pet may have.",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            validator: InputValidator.personaCommunicationStyleValidator,
            hint: "Enter Communication Style",
            controller: communicationStyleController,
            description: "Describe how your pet communicates or responds to you",
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if(formKey.currentState!.validate())
              {
                navigateTo(ChallengesView(
                  personaName: widget.personaName,
                  type: widget.type,
                  personaModelData: PersonaModelData(
                      name: nameController.text,
                      age: ageController.text,
                      favoriteActivities: favoriteActivitiesController.text,
                      healthConditions: healthController.text,
                      challenges: challengesController.text,
                      communicationStyle: communicationStyleController.text,
                      breed: breedController.text,
                      petType: petTypeController.text
                  ),
                ));
              }

            },
          )
        ],
      ),
    );
  }
}
