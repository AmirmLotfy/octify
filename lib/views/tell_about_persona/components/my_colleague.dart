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
  final PersonaType type;

  const MyColleagueSection({super.key, required this.type});

  @override
  State<MyColleagueSection> createState() => _MyColleagueSectionState();
}

class _MyColleagueSectionState extends State<MyColleagueSection> {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  String? workRelationship;
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
            hint: "Enter your colleague's name",
            controller: nameController,
          ),
          AppInput(
            prefix: "",
            label: "Position",
            hint: "Enter your colleague’s position",
            // validator: InputValidator.personaNameValidator,
            controller: positionController,
          ),
          AppInput(
            prefix: "",
            label: "Department",
            hint: "Which department do they work in?",
            controller: departmentController,
          ),
          AppExpansionTile(
            title: "What is your working relationship with this colleague?",
            label: "Working Relationship",
            onChange: (value) {
              workRelationship = value;
            },
            list: [
              "Peer",
              "Supervisor",
              "Subordinate",
            ],
            icon: '',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (workRelationship == null) {
                  showMessage("you must choose the work relation",
                      type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                        name: nameController.text,
                        type: PersonaType.colleague,
                        position: positionController.text,
                        department: departmentController.text,
                        workRelationship: workRelationship),
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
