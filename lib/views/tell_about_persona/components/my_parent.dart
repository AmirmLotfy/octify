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

  const MyParentSection(
      {super.key,  required this.type});

  @override
  State<MyParentSection> createState() => _MyParentSectionState();
}

class _MyParentSectionState extends State<MyParentSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  // final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final healthController = TextEditingController();
  final communicationStyleController = TextEditingController();
  final lifeStageController = TextEditingController();
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
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            label: " Name",
            hint: "Enter your parent's name",
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",
            validator: InputValidator.personaAgeValidator,
            controller: ageController,
            hint: "Specify your parent's age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your parent's gender",
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
            controller: interestsController,
            label: "Interests/Hobbies",
            hint: "Enter Interests/Hobbies",
            validator: InputValidator.personaInterestsHobbiesValidator,
            description: "Add your parent's hobbies or favorite activities",
          ),
          // AppInput(
          //   prefix: "challenges.png",
          //   label: "Challenges",
          //   controller: challengesController,
          //   hint: "Enter Challenges",
          //   description: "List any challenges your parent may be facing",
          // ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            controller: personalityTypeController,
            hint: "Enter Personality Type",
            description: "Choose your parent's personality type",
          ),
          AppInput(
            prefix: "health.png",
            label: "Health Conditions",
            controller: healthController,
            hint: "Enter Health Conditions",
            validator: InputValidator.personaHealthConditionsValidator,
            description: "Include any health conditions for better guidance",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            controller: communicationStyleController,
            hint: "Enter Communication Style",
            description: "Select how your parent prefers to communicate",
          ),
          AppInput(
            prefix: "life_stage.png",
            label: "Life Stage",
            controller: lifeStageController,
            hint: "Life Stage",
            description: "Indicate their current life stage (e.g., retirement)",
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if(formKey.currentState!.validate())
              {
                if (gender == null) {
                  showMessage("Gender must be not null", type: MessageType.warning);
                } else {
                  navigateTo(
                    ChallengesView(
                      personaName: nameController.text,
                      type: widget.type,
                      personaModelData: PersonaModelData(
                        name: nameController.text,
                        age: ageController.text,
                        gender: gender,
                        personalityType: personalityTypeController.text,
                        // challenges: challengesController.text,
                        healthConditions: healthController.text,
                        interestsHobbies: interestsController.text,
                        lifeStage: lifeStageController.text,
                        communicationStyle: communicationStyleController.text,
                      ),
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
