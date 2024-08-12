import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _ref;

  static Future<void> init() async {
    _ref = await SharedPreferences.getInstance();
  }

  static String get lang {
    return _ref.getString("lang") ?? "en";
  }

  static String get token {
    return _ref.getString("token") ?? "";
  }

  static String get phone {
    return _ref.getString("phone") ?? "+966 1024623 264";
  }

  static int get id {
    return _ref.getInt("id") ?? 1054;
  }

  static bool get isAuthed {
    return token.isNotEmpty;
  }

  static Future<void> setIsAuthed() async {
    _ref.setBool("isAuthed", true);
  }

  static String get name {
    return firstName+" "+lastName;
  }

  static String get _engName {
    return _ref.getString("docEngName") ?? "";
  }

  static String get _arbName {
    return _ref.getString("docArbName") ?? "";
  }

  static String get image {
    return _ref.getString("image") ?? "";
  }

  static String get telephone {
    return _ref.getString("telephone") ?? "";
  }

  static int get fileNum {
    return _ref.getInt("fileNum") ?? 0;
  }

  static String get address {
    return _ref.getString("address") ?? "";
  }

  static bool get isFirstTime {
    return _ref.getBool("isFirstTime") ?? true;
  }

  static Future<void> setNotFirstTime() async {
    _ref.setBool("isFirstTime", false);
  }

  static Future<void> setLang(String lang) async {
    _ref.setString("lang", lang);
  }

  static Future<void> setToken(String token) async {
    debugPrint("Token Saved $token");
    _ref.setString("token", token);
  }

  static Future<void> setRememberMe(bool value) async {
    _ref.setBool("isRememberMe", value);
  }

  static bool get isRememberMe {
    return _ref.getBool("isRememberMe") ?? false;
  }

  static Future<void> saveEmailAndPassword(
      String email, String password) async {
    _ref.setString("email", email);
    _ref.setString("password", password);
  }

  static Future<void> saveUserData({
   required String firstName,
   required String lastName,
   required String image,
   required String phone,
   required String email,
  }) async {
    _ref.setString("firstName", firstName);
    _ref.setString("lastName", lastName);
    _ref.setString("image", image);
    _ref.setString("phone", phone);
    _ref.setString("email", email);
  }
  static String get firstName {
    return _ref.getString("firstName") ?? "";
  }
  static String get lastName {
    return _ref.getString("lastName") ?? "";
  }
  static String get email {
    return _ref.getString("email") ?? "";
  }

  static String get password {
    return _ref.getString("password") ?? "";
  }

  // static Future<void> saveData(UserModel model) async {
  //   _ref.setInt("id", model.id);
  //   _ref.setString("arbName", model.arbName);
  //   _ref.setString("engName", model.engName);
  //   _ref.setString("email", model.email);
  //   _ref.setString("address", model.address);
  //   _ref.setString("image", model.image);
  //   _ref.setString("token", model.token);
  //   _ref.setString("gender", model.gender);
  //   _ref.setString("telephone", model.telephone);
  //   _ref.setInt("fileNum", model.fileNum);
  // }

  static Future<void> logOut() async {

    await _ref.clear();
    await setNotFirstTime();
  }
}
