import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class BabySection extends StatefulWidget {
  final PersonaType type;

  const BabySection({super.key, required this.type});

  @override
  State<BabySection> createState() => _BabySectionState();
}

class _BabySectionState extends State<BabySection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final sleepScheduleController = TextEditingController();
  final developmentalMilestonesController = TextEditingController();
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
            label: "Name",
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            hint: "Enter the baby's name.",
          ),
          AppInput(
            prefix: "age.svg",
            controller: ageController,
            label: "Age",
            validator: InputValidator.personaAgeValidator,
            hint: "Provide the baby's age to track developmental milestones.",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select the baby's gender.",
            label: "Gender",
            onChange: (value) {
              gender = value;
            },
            list: [
              "Male",
              "Female",
              "Other",
            ],
            icon: 'gender.svg',
          ),
          AppInput(
            prefix: "",
            label: "Sleep Schedule",
            controller: sleepScheduleController,
            description: "Track sleep patterns for better routine management.",
            hint: "Track sleep patterns for better routine management.",
          ),
          AppInput(
            prefix: "",
            label: "Name",
            controller: developmentalMilestonesController,
            hint: "Enter the name of your child",
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
                      sleepSchedule: sleepScheduleController.text,
                      developmentalMilestones: developmentalMilestonesController.text,
                      gender: gender,
                      type: PersonaType.baby,
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
