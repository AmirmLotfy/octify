import 'package:flutter/material.dart';
import 'package:octify/core/logic/input_validator.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class GeneralSection extends StatefulWidget {
  final String personaName;
  final PersonaType type;

  const GeneralSection(
      {super.key, required this.personaName, required this.type});

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInput(
            controller: nameController,
            prefix: "user_name.svg",
            label: " Name",
            hint: "Enter name",
            validator: InputValidator.personaNameValidator,
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",
            controller: ageController,
            hint: "Specify age",
            validator: InputValidator.personaAgeValidator,
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select gender",
            onChange: (value) {
              gender = value;
            },
            label: "Gender",
            list: [
              "Male",
              "Female",
              "Other",
              "Prefer not to say",
            ],
            icon: 'gender.svg',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if(formKey.currentState!.validate())
                {
                  if (gender == null) {
                    showMessage(
                        "Gender must be not null", type: MessageType.warning);
                  } else {
                    navigateTo(ChallengesView(
                      personaName: widget.personaName,
                      type: widget.type,
                      personaModelData: PersonaModelData(
                          name: nameController.text,
                          age: ageController.text,
                          gender: gender
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
