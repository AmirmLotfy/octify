import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MyFriendSection extends StatefulWidget {

  final PersonaType type;

  const MyFriendSection(
      {super.key,  required this.type});

  @override
  State<MyFriendSection> createState() => _MyFriendSectionState();
}

class _MyFriendSectionState extends State<MyFriendSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  final sharedInterestsController = TextEditingController();
  // final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final communicationStyleController = TextEditingController();
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
            label: " Name",
            hint: "Enter your friend's name",
            validator: InputValidator.personaNameValidator,

          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",            validator: InputValidator.personaAgeValidator,

            controller: ageController,
            hint: "Specify your friend's age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your friend's gender",
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
            description: "Add your friend's hobbies or favorite pastimes",
          ),
          // AppInput(
          //   prefix: "challenges.png",
          //   label: "Challenges",
          //   controller: challengesController,
          //   hint: "Enter Challenges",
          //   description: "List any challenges your friend may be dealing with",
          // ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            controller: personalityTypeController,
            hint: "Enter Personality Type",
            description: "Choose your friend's personality type",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            controller: communicationStyleController,
            hint: "Enter Communication Style",
            description: "Select how your friend prefers to communicate",
          ),
          AppInput(
            prefix: "interests.png",
            label: "Shared Interests",
            controller: sharedInterestsController,
            validator: InputValidator.personaSharedInterestsValidator,
            hint: "Enter Shared Interests",
            description: "List activities or interests you both enjoy",
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
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                        name: nameController.text,
                        type: PersonaType.friend,
                        age: ageController.text,
                        gender: gender,
                        personalityType: personalityTypeController.text,
                        // challenges: challengesController.text,
                        interestsHobbies: interestsController.text,
                        sharedInterests: sharedInterestsController.text,
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
