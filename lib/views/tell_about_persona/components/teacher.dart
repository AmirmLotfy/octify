import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class TeacherSection extends StatefulWidget {
  final PersonaType type;

  const TeacherSection({super.key, required this.type});

  @override
  State<TeacherSection> createState() => _TeacherSectionState();
}

class _TeacherSectionState extends State<TeacherSection> {
  final nameController = TextEditingController();
  String? subjectTaught, teachingStyle, studentAgeGroup;

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
            hint: "Enter the teacher's full name.",
          ),
          AppExpansionTile(
            title: "Select the subject the teacher specializes in",
            label: "Subject Taught",
            onChange: (value) {
              subjectTaught = value;
            },
            list: [
              "Math",
              "Science",
              "History",
              "Language Arts",
              "Physical Education",
              "Art",
              "Music",
              "Other"
            ],
            icon: '',
          ),
          AppExpansionTile(
            title: "Describe the teacher's preferred teaching style.",
            label: "Teaching Style",
            onChange: (value) {
              teachingStyle = value;
            },
            list: [
              "Traditional",
              "Hands-On",
              "Lecture-Based",
              "Project-Based",
              "Other"
            ],
            icon: '',
          ),
          AppExpansionTile(
            title: "Specify the age group the tea primarily works with.",
            label: "Student Age Group",
            onChange: (value) {
              studentAgeGroup = value;
            },
            list: ["Elementary", "Middle School", "High School", "College"],
            icon: '',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                navigateTo(ChallengesView(
                  personaName: nameController.text,
                  type: widget.type,
                  personaModelData: PersonaModelData(
                    name: nameController.text,
                    subjectTaught: subjectTaught,
                    teachingStyle: teachingStyle,
                    studentAgeGroup: studentAgeGroup,
                    type: PersonaType.teacher,
                  ),
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
