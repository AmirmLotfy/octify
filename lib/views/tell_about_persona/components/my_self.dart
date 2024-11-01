import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MySelfSection extends StatefulWidget {

  final PersonaType type;

  const MySelfSection(
      {super.key,  required this.type});

  @override
  State<MySelfSection> createState() => _MySelfSectionState();
}

class _MySelfSectionState extends State<MySelfSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final currentFocusController = TextEditingController();
  String? gender;
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
            validator: InputValidator.personaNameValidator,
            controller: nameController,
            hint: "Enter your own name",
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",
            validator: InputValidator.personaAgeValidator,
            controller: ageController,
            hint: "Specify your age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your gender",
            label: "Gender",
            onChange: (value) {
              gender = value;
            },
            list: [
              "Male",
              "Female",
              "Non-Binary",
              "Prefer not to say",
            ],
            icon: 'gender.svg',
          ),

          AppInput(
            label: "Current Focus",
            maxLines: 2,
            hint: "What is your current personal focus or goal?",
            controller: currentFocusController,
            validator: InputValidator.personaGoalsValidator,
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (gender == null) {
                  showMessage("Gender must be not null",
                      type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                      name: nameController.text,
                      age: ageController.text,
                      currentFocus: currentFocusController.text,
                      type: PersonaType.myself,

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
