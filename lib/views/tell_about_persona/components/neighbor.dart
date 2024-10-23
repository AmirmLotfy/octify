import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class NeighborSection extends StatefulWidget {
  final PersonaType type;

  const NeighborSection({super.key, required this.type});

  @override
  State<NeighborSection> createState() => _NeighborSectionState();
}

class _NeighborSectionState extends State<NeighborSection> {
  final nameController = TextEditingController();
  final sharedCommunityInterestsController = TextEditingController();
  String? gender,preferredCommunicationMethod;

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
            hint: "Enter your neighbor's full name",
          ),
          AppExpansionTile(
            title: "Select your neighbor's gender",
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
            label: "Shared Community Interests",
            controller: sharedCommunityInterestsController,
            description: "List common community interests for local event suggestions",
          ),

          AppExpansionTile(
            title: "Indicate how your neighbor prefers to communicate",
            label: "Preferred Communication Method",
            onChange: (value) {
              preferredCommunicationMethod = value;
            },
            list: [
              "In-person",
              "Phone",
              "Email",
              "Text",
            ],
            icon: '',
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
                      sharedCommunityInterests: sharedCommunityInterestsController.text,
                      gender: gender,
                      preferredCommunicationMethod: preferredCommunicationMethod,
                      type: PersonaType.neighbor,
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
