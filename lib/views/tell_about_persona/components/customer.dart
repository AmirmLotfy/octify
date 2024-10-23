import 'package:flutter/material.dart';
import 'package:octify/views/tell_about_persona/view.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_expansion_tile.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/logic/input_validator.dart';
import '../../challenges.dart';
import '../../select_persona.dart';

class CustomerSection extends StatefulWidget {
  final PersonaType type;

  const CustomerSection({super.key, required this.type});

  @override
  State<CustomerSection> createState() => _CustomerSectionState();
}

class _CustomerSectionState extends State<CustomerSection> {
  final nameController = TextEditingController();
  final purchaseHistoryController = TextEditingController();
  String? preferredCommunicationMethod;

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
            hint: "Enter the customer's name to personalize the experience.",
          ),
          AppExpansionTile(
            title: "Select the customer's preferred contact method.",
            label: "Preferred Communication Method",
            onChange: (value) {
              preferredCommunicationMethod = value;
            },
            list: [
              "Email",
              "Phone",
              "Text",
              "Social Media",
            ],
            icon: '',
          ),
          AppInput(
            prefix: "",
            label: "Purchase History",
            controller: purchaseHistoryController,
            description: "Track previous purchases to tailor recommendations.",
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
                    purchaseHistory: purchaseHistoryController.text,
                    preferredCommunicationMethod: preferredCommunicationMethod,
                    type: PersonaType.customer,
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
