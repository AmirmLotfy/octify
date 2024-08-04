import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/select_persona.dart';

class CreatePersonaPage extends StatelessWidget {
  const CreatePersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppImage("create_persona.svg"),
            Text(
              "Create a unique persona to tailor solutions\nthat perfectly align with your needs.",
              style:
                  TextStyle(fontSize: 16.sp, color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            FilledButton.icon(
              icon: const AppImage("add.svg"),
              onPressed: () {
                navigateTo(SelectPersonaView());
              },
              label: const Text("Create Persona"),
            )
          ],
        ),
      ),
    );
  }
}
