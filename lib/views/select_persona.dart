import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/tell_about_persona.dart';

import '../core/design/second_app_bar.dart';

class SelectPersonaView extends StatefulWidget {
  const SelectPersonaView({super.key});

  @override
  State<SelectPersonaView> createState() => _SelectPersonaViewState();
}

class _SelectPersonaViewState extends State<SelectPersonaView> {
  final list = [
    _Model(text: "Parent", image: "parent.svg", color: const Color(0xff7FD2F2)),
    _Model(text: "Child", image: "child.svg", color: const Color(0xffA6B2EE)),
    _Model(
        text: "Partner", image: "partner.svg", color: const Color(0xff8FD1CD)),
    _Model(
        text: "Myself", image: "my_self.svg", color: const Color(0xffEBCAE7)),
    _Model(
        text: "Colleague",
        image: "colleague.svg",
        color: const Color(0xff96D9B0)),
    _Model(text: "Friend", image: "friend.svg", color: const Color(0xffFEDEA5)),
    _Model(text: "My Pet", image: "my_pet.svg", color: const Color(0xffFFCFB9)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Persona Selection"),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                children: [
                  const TextSpan(text: "Who do you want"),
                  TextSpan(
                      text: " to deal\nwith?",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 165.w / 117.h,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h),
                itemBuilder: (context, index) => _Item(
                  model: list[index],
                ),
                itemCount: list.length,
              ),
            ),
            SizedBox(height: 24.h),
            // todo: hide button until the user write in the input
            const AppInput(
              label: "Other Persona",
              hint: "Enter other persona",
            ),
            FilledButton(onPressed: () {}, child: const Text("Next"))
          ],
        ),
      ),
    );
  }
}

class _Model {
  final String text, image;
  final Color color;

  _Model({required this.text, required this.image, required this.color});
}

class _Item extends StatelessWidget {
  final _Model model;

  const _Item({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(TellAboutPersonaView(personaName: model.text,));
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: model.color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(
              model.text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            AppImage(
              model.image,
              height: 48.h,
              width: 48.h,
            )
          ],
        ),
      ),
    );
  }
}
