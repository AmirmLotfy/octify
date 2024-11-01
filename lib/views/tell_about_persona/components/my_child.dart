import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class MyChildSection extends StatefulWidget {
  final PersonaType type;

  const MyChildSection({super.key, required this.type});

  @override
  State<MyChildSection> createState() => _MyChildSectionState();
}

class _MyChildSectionState extends State<MyChildSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String? gender, relationship;
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
            label: "Name",
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            hint: "Enter the name of your child",
          ),
          AppInput(
            prefix: "age.svg",
            controller: ageController,
            label: "Age",
            validator: InputValidator.personaAgeValidator,
            hint: "Specify the age of your child",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your child’s gender",
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
          AppExpansionTile(
            title: "Specify your relationship to the child",
            label: "Relationship",
            onChange: (value) {
              relationship = value;
            },
            list: [
              "Biological",
              "Adopted",
              "Stepchild",
            ],
            icon: 'relationship.png',
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
                        gender: gender,
                        type: PersonaType.child,
                        relationship: relationship),
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
