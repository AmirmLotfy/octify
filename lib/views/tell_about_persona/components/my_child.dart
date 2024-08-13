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

  const MyChildSection(
      {super.key,  required this.type});

  @override
  State<MyChildSection> createState() => _MyChildSectionState();
}

class _MyChildSectionState extends State<MyChildSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final interestsController = TextEditingController();
  // final challengesController = TextEditingController();
  final personalityTypeController = TextEditingController();
  final healthController = TextEditingController();
  final communicationStyleController = TextEditingController();
  final educationLevelController = TextEditingController();
  final favoriteActivitiesController = TextEditingController();
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
            controller: nameController,
            validator: InputValidator.personaNameValidator,
            hint: "Enter your child's name",
          ),
          AppInput(
            prefix: "age.svg",
            controller: ageController,
            label: "Age",
            validator: InputValidator.personaAgeValidator,
            hint: "Specify your child's age",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your child's gender",
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
            description: "Add your child's hobbies or passions",
          ),
          // AppInput(
          //   prefix: "challenges.png",
          //   label: "Challenges",
          //   controller: challengesController,
          //   hint: "Enter Challenges",
          //   description: "List any difficulties your child may be facing",
          // ),
          AppInput(
            prefix: "personality_type.png",
            label: "Personality Type",
            controller: personalityTypeController,
            hint: "Enter Personality Type",
            description:
                "Choose a personality type to better understand your child",
          ),
          AppInput(
            prefix: "health.png",
            label: "Health Conditions",
            validator: InputValidator.personaHealthConditionsValidator,
            hint: "Enter Challenges",
            controller: healthController,
            description: "Include any relevant health conditions",
          ),
          AppInput(
            prefix: "communication_style.png",
            label: "Communication Style",
            controller: communicationStyleController,
            hint: "Enter Communication Style",
            description: "Select how your child prefers to communicate",
          ),
          AppInput(
            prefix: "education.png",
            label: "Education Level",
            controller: educationLevelController,
            validator: InputValidator.personaEducationLevelValidator,
            keyboardType: TextInputType.text,
            hint: "Enter Education Level",
            description:
                "Indicate your child's current grade or educational stage",
          ),
          AppInput(
            prefix: "favorite_activities.png",
            label: "Favorite Activities",
            controller: favoriteActivitiesController,
            // validator: InputValidator.personaFavoriteActivitiesValidator,
            hint: "Enter Favorite Activities",
            description: "List activities your child enjoys most",
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
                        gender: gender,
                        type: PersonaType.child,
                        personalityType: personalityTypeController.text,
                        // challenges: challengesController.text,
                        healthConditions: healthController.text,
                        interestsHobbies: interestsController.text,
                        favoriteActivities: favoriteActivitiesController.text,
                        educationLevel: educationLevelController.text,
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
