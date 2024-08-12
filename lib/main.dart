import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';

import 'package:octify/core/theme.dart';
import 'package:octify/views/auth/login.dart';
import 'package:octify/views/auth/on_boarding.dart';
import 'package:octify/views/auth/register.dart';
import 'package:octify/views/chat.dart';
import 'package:octify/views/home/view.dart';
import 'package:octify/views/select_persona.dart';
import 'package:octify/views/settings/help.dart';
import 'package:octify/views/settings/privacy.dart';

import 'core/logic/cache_helper.dart';
import 'core/logic/firebase_notifications.dart';
import 'features/get_messages/bloc.dart';
import 'features/service_locator.dart';
import 'firebase_options.dart';
import 'views/auth/splash.dart';
import 'views/challenges.dart';
import 'views/chat/view.dart';
import 'views/results.dart';
import 'views/tell_about_persona/view.dart';

// todo: download google services again and replace with android and ios because we add google sign in
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await GlobalNotification().setUpFirebase();
  await CacheHelper.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initKiwi();
  // await GetMessagesBloc.initHive();
  // await FirebaseAuth.instance.signOut();
  // await CacheHelper.logOut();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        debugPrint(user.uid);
        debugPrint("*" * 30);
        debugPrint("User is signed in");
      } else {
        debugPrint("*" * 30);
        debugPrint("User is currently signed out!");
      }
    });
  }

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
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.sp),
            ),
            child: child!,
          ),
          home: SplashView(),
        );
      },
    );
  }
}