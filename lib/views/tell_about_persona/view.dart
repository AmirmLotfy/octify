import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';
import 'package:octify/views/tell_about_persona/components/my_colleague.dart';
import 'package:octify/views/tell_about_persona/components/my_partner.dart';

import '../select_persona.dart';
import 'components/my_child.dart';
import 'components/my_friend.dart';
import 'components/my_parent.dart';
import 'components/my_pet.dart';
import 'components/my_self.dart';

class TellAboutPersonaView extends StatefulWidget {
  final String personaName;
  final PersonaType personaType;

  const TellAboutPersonaView(
      {super.key, required this.personaName, required this.personaType});

  @override
  State<TellAboutPersonaView> createState() => _TellAboutPersonaViewState();
}

class _TellAboutPersonaViewState extends State<TellAboutPersonaView> {
  final list = ["Peanuts", "Shellfish", "Pollen", "Pollen", "Hypertension"];
  List<int> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Tell us more about Persona"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  const TextSpan(
                      text: "Please provide the following details to help us "),
                  TextSpan(
                    text: "understand your needs better.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            if (widget.personaType == PersonaType.child)
              MyChildSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.partner)
              MyPartnerSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.parent)
              MyParentSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.friend)
              MyFriendSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.myself)
              MySelfSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.pet)
              MyPetSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),
            if (widget.personaType == PersonaType.colleague)
              MyColleagueSection(
                personaName: widget.personaName,
                type: widget.personaType,
              ),

            //todo: make it like the comment months and years
            //   const AppInput(
            //     prefix: "",
            //     label: "Relationship Duration",
            //     hint: "MM/YY",
            //     keyboardType: TextInputType.number,
            //   ),

            // // todo: make add button and clickable to show sheet
            // // in the sheet he enter the name of the date and select the date
            // // from calendat and then press save and it shown below the item
            // // he also can delete or edit it when click on it
            //   const AppInput(
            //     prefix: "",
            //     label: "Important Dates",
            //     hint: "Enter your important dates",
            //     keyboardType: TextInputType.number,
            //   ),
            // SizedBox(height: 16.h),
            // Text(
            //   "Allergies",
            //   style: TextStyle(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            // SizedBox(height: 16.h),
            // Wrap(
            //   alignment: WrapAlignment.start,
            //   crossAxisAlignment: WrapCrossAlignment.start,
            //   spacing: 16.w,
            //   runSpacing: 16.h,
            //   children: List.generate(
            //     list.length,
            //     (index) => GestureDetector(
            //       onTap: () {
            //         if (selectedList.contains(index)) {
            //           selectedList.remove(index);
            //         } else {
            //           selectedList.add(index);
            //         }
            //
            //         setState(() {});
            //       },
            //       child: Container(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 27.w,
            //           vertical: 8.h,
            //         ),
            //         decoration: BoxDecoration(
            //             color: selectedList.contains(index)
            //                 ? Theme.of(context).primaryColor
            //                 : null,
            //             border: !selectedList.contains(index)
            //                 ? Border.all(
            //                     color: Theme.of(context).dividerColor,
            //                   )
            //                 : null,
            //             borderRadius: BorderRadius.circular(8.r)),
            //         child: Text(
            //           list[index],
            //           style: TextStyle(
            //             fontSize: 12.sp,
            //             color: selectedList.contains(index)
            //                 ? Colors.white
            //                 : const Color(0xff8c8c8c),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 24.h),
            // TextFormField(
            //   minLines: 3,
            //   maxLines: 7,
            //   decoration: const InputDecoration(
            //     hintText: "Medical/Mental Health Issues",
            //   ),
            // ),
            // SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
