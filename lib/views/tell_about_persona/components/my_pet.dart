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
  final PersonaType type;

  const MyPetSection({super.key, required this.type});

  @override
  State<MyPetSection> createState() => _MyPetSectionState();
}

class _MyPetSectionState extends State<MyPetSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final favoriteTreatsController = TextEditingController();
  final breedController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? species;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInput(
            prefix: "pet_name.svg",
            label: " Name",
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            hint: "Enter your pet's name",
          ),
          AppExpansionTile(
            title: "Select your pet’s species.",
            label: "Species",
            onChange: (value) {
              species = value;
            },
            list: [
              "Dog",
              "Cat",
              "Bird",
              "Fish",
              "Reptile",
              "Other",
            ],
            icon: 'species.png',
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",
            controller: ageController,
            hint: "Specify the age of your pet.",
            keyboardType: TextInputType.number,
          ),
          AppInput(
            label: "Breed",
            maxLines: 2,
            hint: "Enter the breed of your pet, if applicable.",
            controller: breedController,
          ),
          AppInput(
            label: "Favorite Treats",
            maxLines: 2,
            hint: "List your pet's favorite treats for reward suggestions.",
            controller: favoriteTreatsController,
            keyboardType: TextInputType.number,
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (species == null) {
                  showMessage("you must choose the species",
                      type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                      name: nameController.text,
                      species: species,
                      age: ageController.text,
                      breed: breedController.text,
                      favoriteTreats: favoriteTreatsController.text,
                      type: PersonaType.pet,
                    ),
                  ));
                }

              }
            },
          )
        ],
      ),
    );
  }
}
