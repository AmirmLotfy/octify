import 'package:flutter/material.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';
import '../view.dart';

class MyPartnerSection extends StatefulWidget {

  final PersonaType type;

  const MyPartnerSection(
      {super.key,  required this.type});

  @override
  State<MyPartnerSection> createState() => _MyPartnerSectionState();
}

class _MyPartnerSectionState extends State<MyPartnerSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  // final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final communicationStyleController = TextEditingController();
  final loveLanguageController = TextEditingController();
  final anniversaryController = TextEditingController();
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
            hint: "Enter your partner's name",
          ),
          AppInput(
            prefix: "age.svg",
            label: "Age",            validator: InputValidator.personaAgeValidator,

            controller: ageController,
            hint: "Specify your partner's age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your partner's gender",
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
            validator: InputValidator.personaInterestsHobbiesValidator,
            hint: "Enter Interests/Hobbies",
            controller: interestsController,
            description: "Add your partner's favorite activities or hobbies",
          ),
          // AppInput(
          //   prefix: "challenges.png",
          //   label: "Challenges",
          //   controller: challengesController,
          //   hint: "Enter Challenges",
          //   description: "List any difficulties your partner may be facing",
          // ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            controller: personalityTypeController,
            hint: "Enter Personality Type",
            description:
                "Choose your partner's personality type for tailored insights",
          ),
          AppInput(
            prefix: "love_language.png",
            label: "Love Language",
            validator: InputValidator.personaLoveLanguageValidator,
            controller: loveLanguageController,
            hint: "Enter Love Language",
            description:
                "Select their preferred way of expressing and receiving love",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            controller: communicationStyleController,
            hint: "Enter Communication Style",
            description: "Choose how your partner prefers to communicate",
          ),
          AppInput(
            prefix: "anniversary.png",
            label: "Anniversary Date",
            validator: InputValidator.personaAnniversaryDateValidator,
            controller: anniversaryController,
            hint: "Enter Anniversary Date",
            description:
                "Enter the date of your anniversary for important reminders",
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
                      age: ageController.text,
                      anniversaryDate: anniversaryController.text,
                      gender: gender,
                      personalityType: personalityTypeController.text,
                      // challenges: challengesController.text,
                      interestsHobbies: interestsController.text,
                      loveLanguage: loveLanguageController.text,
                      communicationStyle: communicationStyleController.text,
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
