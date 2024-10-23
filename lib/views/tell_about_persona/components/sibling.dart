import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class SiblingSection extends StatefulWidget {
  final PersonaType type;

  const SiblingSection({super.key, required this.type});

  @override
  State<SiblingSection> createState() => _SiblingSectionState();
}

class _SiblingSectionState extends State<SiblingSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String? birthOrder, liveTogether;
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
            hint: "Enter your sibling’s name.",
          ),
          AppInput(
            prefix: "age.svg",
            controller: ageController,
            label: "Age",
            hint: "Specify your sibling’s age.",
            keyboardType: TextInputType.number,
          ),
          AppExpansionTile(
            title: "Select your sibling’s birth order relative to you.",
            label: "Birth Order",
            onChange: (value) {
              birthOrder = value;
            },
            list: [
              "Older",
              "Younger",
              "Twin",
            ],
            icon: 'gender.svg',
          ),
          AppExpansionTile(
            title: "Do you live together?",
            label: "Live Together",
            onChange: (value) {
              liveTogether = value;
            },
            list: [
              "Yes",
              "No",
              "Occasionally",
            ],
            icon: '',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (birthOrder == null) {
                  showMessage("You must choose the Birth Order",
                      type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                        name: nameController.text,
                        age: ageController.text,
                        birthOrder: birthOrder,
                        type: PersonaType.sibling,
                        liveTogether: liveTogether),
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
