import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class TeenagerSection extends StatefulWidget {
  final PersonaType type;

  const TeenagerSection({super.key, required this.type});

  @override
  State<TeenagerSection> createState() => _TeenagerSectionState();
}

class _TeenagerSectionState extends State<TeenagerSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final friendGroupController = TextEditingController();
  String? relationship, currentSchoolYear;
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
            hint: "Enter the teenager’s name.",
          ),
          AppInput(
            prefix: "age.svg",
            controller: ageController,
            validator: InputValidator.personaAgeValidator,
            label: "Age",
            hint: "Specify the teenager’s age.",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "What is your relationship to this teenager?",
            label: "Relationship to You",
            onChange: (value) {
              relationship = value;
            },
            list: [
              "Child",
              "Sibling",
              "Friend",
              "Other",
            ],
            icon: '',
          ),
          AppExpansionTile(
            title:
                "Specify their school year for educational and social advice",
            label: "Current School Year",
            onChange: (value) {
              currentSchoolYear = value;
            },
            list: [
              "Freshman",
              "Sophomore",
              "Junior",
              "Senior",
              "Middle School",
            ],
            icon: '',
          ),
          AppInput(
            prefix: "",
            controller: friendGroupController,
            label: "Friend Group",
            hint: "Describe their friend group to understand social dynamics.",
            keyboardType: TextInputType.number,
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                navigateTo(ChallengesView(
                  personaName: nameController.text,
                  type: widget.type,
                  personaModelData: PersonaModelData(
                      name: nameController.text,
                      age: ageController.text,
                      friendGroup: friendGroupController.text,
                      relationship: relationship,
                      type: PersonaType.teenager,
                      currentSchoolYear: currentSchoolYear),
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
