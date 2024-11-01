import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MyParentSection extends StatefulWidget {
  final PersonaType type;

  const MyParentSection({super.key, required this.type});

  @override
  State<MyParentSection> createState() => _MyParentSectionState();
}

class _MyParentSectionState extends State<MyParentSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final healthController = TextEditingController();
  final occupationController = TextEditingController();
  String? relationship, liveSituation;
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
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            label: "Name",
            hint: "Enter the name of your parent",
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",
            controller: ageController,
            hint: "Specify the age of your parent",
            keyboardType: TextInputType.number,
          ),
          // todo: new ---> need relationship icon
          AppExpansionTile(
            title: "Select the type of relationship you have",
            label: "Relationship Type",
            onChange: (value) {
              relationship = value;
            },
            list: [
              "Father",
              "Mother",
              "Stepfather",
              "Stepmother",
            ],
            icon: 'relationship.png',
          ),
          AppExpansionTile(
            title: "Indicate your living situation",
            label: "Living Situation",
            onChange: (value) {
              liveSituation = value;
            },
            list: [
              "Your Parent lives with you",
              "Lives separately",
              "Deceased",
            ],
            icon: 'living_together.png',
          ),
          AppInput(
            label: "Health Concerns",
            maxLines: 2,
            controller: healthController,
            hint: "Note any health concerns to receive tailored advice.",
          ),
          AppInput(
            label: "Occupation",
            maxLines: 2,
            controller: occupationController,
            hint: "Enter the parent's occupation to contextualize their daily life.",
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (relationship == null) {
                  showMessage("Relationship must be not null",
                      type: MessageType.warning);
                } else {
                  navigateTo(
                    ChallengesView(
                      personaName: nameController.text,
                      type: widget.type,
                      personaModelData: PersonaModelData(
                          name: nameController.text,
                          type: PersonaType.parent,
                          age: ageController.text,
                          relationship: relationship,
                          occupation: occupationController.text,
                          healthConcerns: healthController.text,
                          liveSituation: liveSituation),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
