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

  const MyFriendSection({super.key, required this.type});

  @override
  State<MyFriendSection> createState() => _MyFriendSectionState();
}

class _MyFriendSectionState extends State<MyFriendSection> {
  final nameController = TextEditingController();
  final friendshipDurationController = TextEditingController();
  String? friendshipType, frequencyOfInteraction;
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
            label: "Name",
            hint: "Enter your friend's name",
            validator: InputValidator.personaNameValidator,
          ),
          AppInput(
            prefix: "friend.svg",
            prefixColor:  Color(0xff8C8C8C),
            label: "Friendship Duration",
            hint: "How long have you been friends?",
            keyboardType: TextInputType.number,
            controller: friendshipDurationController,
          ),
          AppExpansionTile(
            title: "Select the type of friendship.",
            label: "Friendship Type",
            onChange: (value) {
              friendshipType = value;
            },
            list: [
              "Childhood",
              "College",
              "Work",
              "Online",
              "Other",
            ],
            icon: 'sibling.svg',
          ),
          AppExpansionTile(
            title: "How often do you interact?",
            label: "Frequency of Interaction",
            onChange: (value) {
              frequencyOfInteraction = value;
            },
            list: [
              "Daily",
              "Weekly",
              "Monthly",
              "Rarely",
            ],
            icon: 'relationship.png',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                navigateTo(ChallengesView(
                  personaName: nameController.text,
                  type: widget.type,
                  personaModelData: PersonaModelData(
                    type: PersonaType.friend,
                    name: nameController.text,
                    friendshipType: friendshipType,
                    frequencyOfInteraction: frequencyOfInteraction,
                    friendshipDuration: friendshipDurationController.text,
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
