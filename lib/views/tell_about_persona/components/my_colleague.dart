import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MyColleagueSection extends StatefulWidget {
  final String personaName;
  final PersonaType type;

  const MyColleagueSection(
      {super.key, required this.personaName, required this.type});

  @override
  State<MyColleagueSection> createState() => _MyColleagueSectionState();
}

class _MyColleagueSectionState extends State<MyColleagueSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final communicationStyleController = TextEditingController();
  final workRelationshipController = TextEditingController();
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
            hint: "Enter your colleague's name",
            validator: InputValidator.personaNameValidator,
            controller: nameController,
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",            validator: InputValidator.personaAgeValidator,

            controller: ageController,
            hint: "Specify your colleague's age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your colleague's gender",
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
            validator: InputValidator.personaInterestsHobbiesValidator,
            hint: "Enter Interests/Hobbies",
            description: "Add your colleague's professional interests or hobbies",
          ),
          AppInput(
            prefix: "challenges.png",
            label: "Challenges",
            validator: InputValidator.personaChallengesValidator,
            controller: challengesController,
            hint: "Enter Challenges",
            description: "List any workplace challenges you both face",
          ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            validator: InputValidator.personaPersonalityTypeValidator,
            controller: personalityTypeController,
            hint: "Enter Personality Type",
            description: "Choose your colleague's personality type",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            validator: InputValidator.personaCommunicationStyleValidator,
            controller: communicationStyleController,
            hint: "Enter Communication Style",
            description: "Choose how your colleague prefers to communicate",
          ),
          AppInput(
            prefix: "work_relationship.png",
            label: "Work Relationship",
            validator: InputValidator.personaWorkRelationshipValidator,
            controller: workRelationshipController,
            hint: "Enter Work Relationship",
            description:
                "Define the nature of your professional relationship (e.g., peer, supervisor).",
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if(formKey.currentState!.validate())
              {
                if (gender == null) {
                  showMessage("Gender must be not null", type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: widget.personaName,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                        name: nameController.text,
                        age: ageController.text,
                        gender: gender,
                        personalityType: personalityTypeController.text,
                        challenges: challengesController.text,
                        interestsHobbies: interestsController.text,
                        workRelationship: workRelationshipController.text,
                        communicationStyle: communicationStyleController.text),
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
