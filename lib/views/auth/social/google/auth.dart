import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // await FirebaseMessaging.instance.getToken().then((value) async {
    //   log(value.toString());
    // });
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        if (googleSignInAuthentication.accessToken != null) {
          log('token: ${googleSignInAuthentication.accessToken}');
          // await DioHelper.postData(path: 'login/google', data: {
          //   'access_provider_token': googleSignInAuthentication.accessToken,
          //   'provider': 'google',
          //   'device_token': CachedHelper.getFCMToken(),
          // }).then((value) {
          //   if (value!.data['status'] == true) {
          //     CachedHelper.setUserToken(value.data['data']['token']);
          //     CachedHelper.setUserName(value.data['data']['user']['username']);
          //     CachedHelper.setPhone(value.data['data']['user']['phone']);
          //     CachedHelper.setUserId(value.data['data']['user']['id']);
          //     CachedHelper.setAddress(
          //         value.data['data']['user']['current_address']['address']);
          //     CachedHelper.setCityId(
          //         value.data['data']['user']['current_address']['city_id']);
          //     RouteManager.navigateAndPopAll(const HomePage());
          //   }
          // }).catchError((onError) {
          //   customToast(onError.toString());
          // });
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }
}
