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
  final String personaName;
  final PersonaType type;

  const MySelfSection(
      {super.key, required this.personaName, required this.type});

  @override
  State<MySelfSection> createState() => _MySelfSectionState();
}

class _MySelfSectionState extends State<MySelfSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final healthController = TextEditingController();
  final goalsController = TextEditingController();
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
              "Other",
              "Prefer not to say",
            ],
            icon: 'gender.svg',
          ),
          AppInput(
            prefix: "interests.png",
            label: "Interests/Hobbies",
            controller: interestsController,
            hint: "Enter Interests/Hobbies",
            validator: InputValidator.personaInterestsHobbiesValidator,
            description: "Add your personal interests or hobbies",
          ),
          AppInput(
            prefix: "challenges.png",
            controller: challengesController,
            label: "Challenges",
            hint: "Enter Challenges",
            validator: InputValidator.personaChallengesValidator,
            description: "List any personal challenges you're facing",
          ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            controller: personalityTypeController,
            validator: InputValidator.personaPersonalityTypeValidator,
            hint: "Enter Personality Type",
            description: "Choose your personality type for self-insight",
          ),
          AppInput(
            prefix: "health.png",
            label: "Health Conditions",
            hint: "Enter Health Conditions",
            validator: InputValidator.personaHealthConditionsValidator,
            controller: healthController,
            description: "Include any health conditions for self-care guidance",
          ),
          AppInput(
            prefix: "goals.png",
            label: "Goals",
            hint: "Enter Goals",
            controller: goalsController,
            validator: InputValidator.personaGoalsValidator,
            description: "Specify personal goals you want to achieve",
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
                    personaName: widget.personaName,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                      name: nameController.text,
                      age: ageController.text,
                      goals: goalsController.text,
                      healthConditions: healthController.text,
                      personalityType: personalityTypeController.text,
                      challenges: challengesController.text,
                      interestsHobbies: interestsController.text,
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
