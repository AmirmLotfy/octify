import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthentication {
  static Future<User?> signInWithApple({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(oauthCredential);
      log('token: ${userCredential.user!.uid}');
      log('email: ${userCredential.user!.email}');
      log('name: ${userCredential.user!.displayName}');
      log('image: ${userCredential.user!.photoURL}');
      log('phone: ${userCredential.user!.phoneNumber}');
      log('provider: ${userCredential.user!.providerData}');
      log('token: ${credential.identityToken}');
      // await DioHelper.postData(path: 'login/apple', data: {
      //   'access_provider_token': credential.identityToken,
      //   'provider': 'apple',
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
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
