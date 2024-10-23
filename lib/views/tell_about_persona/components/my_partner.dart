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

  const MyPartnerSection({super.key, required this.type});

  @override
  State<MyPartnerSection> createState() => _MyPartnerSectionState();
}

class _MyPartnerSectionState extends State<MyPartnerSection> {
  final nameController = TextEditingController();
  final durationOfRelationController = TextEditingController();
  String? relationStatus, liveTogether, loveLanguage;
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
          AppExpansionTile(
            title: "Select your relationship status.",
            label: "Relationship Status",
            onChange: (value) {
              relationStatus = value;
            },
            list: [
              "Married",
              "Dating",
              "Engaged",
              "Domestic Partners",
            ],
            icon: '',
          ),
          AppInput(
            prefix: "",
            label: "Duration of Relationship",
            hint: "How long have you been together?",
            keyboardType: TextInputType.number,
            controller: durationOfRelationController,
            description:
                "How long have you been together? (Number Input - Years)",
          ),
          AppExpansionTile(
            title: "Do you live together?",
            label: "Living Together",
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
          AppExpansionTile(
            title:
                "Choose your partner's primary love language for relationship tips.",
            label: "Love Language",
            onChange: (value) {
              loveLanguage = value;
            },
            list: [
              "Words of Affirmation",
              "Acts of Service",
              "Receiving Gifts",
              "Quality Time",
              "Physical Touch",
            ],
            icon: '',
          ),
          AppButton(
            text: "Next",
            onPress: () {
              if (formKey.currentState!.validate()) {
                if (relationStatus == null) {
                  showMessage("you must choose your Relation Status",
                      type: MessageType.warning);
                } else {
                  navigateTo(ChallengesView(
                    personaName: nameController.text,
                    type: widget.type,
                    personaModelData: PersonaModelData(
                        name: nameController.text,
                        type: PersonaType.partner,
                        loveLanguage: loveLanguage,
                        liveTogether: liveTogether,
                        relationStatus: relationStatus),
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
