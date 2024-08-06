import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/core/theme.dart';
import 'package:octify/views/auth/login.dart';
import 'package:octify/views/auth/on_boarding.dart';
import 'package:octify/views/home/view.dart';
import 'package:octify/views/settings/help.dart';
import 'package:octify/views/settings/privacy.dart';

import 'features/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initKiwi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 1040),
      minTextAdapt: true,
      builder: (context, c) {
        return MaterialApp(
          title: 'Octify',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.sp)),
              child: child!),
          home: const HomeView(),
        );
      },
    );
  }
}
// Firebase
//  Register ( first name - last name - email address - phone number - password )
//  Login ( email address - password )
