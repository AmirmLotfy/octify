import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage data) async {

  // If you're going to use other Firebase services in the dat, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  GlobalNotification().showNotification(data);
  // _onMessageStreamController.add(message.data);
  // if (Platform.isAndroid) {
  //   GlobalNotification().showNotificationWithAttachment(
  //       data.data,
  //       data.notification.title,
  //       data.notification.body,
  //       data.notification.android.imageUrl);
  // } else {
  //   GlobalNotification().showNotificationWithAttachment(
  //       data.data,
  //       data.notification.title,
  //       data.notification.body,
  //       data.notification.apple.imageUrl);
  // }
  // print("Handling a background message: ${data.data}");
}
//todo there is error while send notification on backgroud fix it
class GlobalNotification {
  static String _deviceToken = "";

  static Future<String> getFcmToken() async {
    try {
      if (_deviceToken != "") {
        return _deviceToken;
      }
      _deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
      // if (UserModel.instance.isAuth && Prefs.getString("device_token") != _deviceToken) {
      //   GlobalNotification().updateFcm();
      // }
      // Prefs.setString("device_token", _deviceToken);
      print("--------- Global Notification Logger --------> \x1B[37m------ FCM TOKEN -----\x1B[0m");
      print('<--------- Global Notification Logger --------> \x1B[32m $_deviceToken\x1B[0m');
      // print("device token : $_deviceToken");
      return _deviceToken;
    } catch (e) {
      return _deviceToken;
    }
  }

  late FirebaseMessaging _firebaseMessaging;
  // updateFcm() async {
  //   CustomResponse response = await ServerGate.i.sendToServer(url: "contributor/fcm_update", body: {
  //     "type": Platform.isAndroid ? "android" : "ios",
  //     "device_token": _deviceToken,
  //   });
  //   if (response.statusCode == 200) {
  //     log('<--------- Fcm was updated successfly --------> \x1B[32m $_deviceToken\x1B[0m');
  //   }
  // }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }

  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  Map<String, dynamic> _not = {};

  Future<void> setUpFirebase() async {
    getFcmToken();

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // checkLastMessage();

    firebaseCloudMessagingListeners();
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      await _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } else {
      await _notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // var android = const AndroidInitializationSettings("");
    var android = const AndroidInitializationSettings('ic_notify');
    var ios = const DarwinInitializationSettings(
      defaultPresentBadge: true,
      defaultPresentAlert: true,
      defaultPresentSound: true,
    );
    var initSetting = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSetting, onDidReceiveNotificationResponse: onSelectNotification);
  }

  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage data) {
      log("--------- Global Notification Logger --------> \x1B[37m------ on Notification message data -----\x1B[0m");
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.data}\x1B[0m');
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.notification?.toMap()}\x1B[0m');
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.notification?.android?.channelId}\x1B[0m');
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.notification?.android?.sound}\x1B[0m');
      _onMessageStreamController.add(data.data);

      _not = data.data;
      // if (Platform.isAndroid) {
      showNotification(data);
      // } else {
      //   // showNotificationWithAttachment(data);
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      log("--------- Global Notification Logger --------> \x1B[37m------ on Opened -----\x1B[0m");
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.data}\x1B[0m');
      log('<--------- Global Notification Logger --------> \x1B[32m ${data.notification?.android?.channelId}\x1B[0m');
      handlePath(data.data);
    });
  }

  // showNotification(Map<String, dynamic> message, String title, String body) async {
  //   var androidt = AndroidNotificationDetails('channel_id', "BUBUZY Distributer",
  //       channelDescription: "BUBUZY Distributer",
  //       priority: Priority.high,
  //       channelShowBadge: true,
  //       sound: const RawResourceAndroidNotificationSound("notification_sound"),
  //       playSound: true,
  //       ticker: 'ticker',
  //       colorized: true,
  //       color: "#2F6699".toColor,
  //       icon: "drawable/notification_icon",
  //       enableVibration: true,
  //       enableLights: true,
  //       importance: Importance.max);
  //   var iost = const DarwinNotificationDetails();
  //   var platform = NotificationDetails(android: androidt, iOS: iost);
  //   await _notificationsPlugin.show(0, title, body, platform, payload: "");
  // }

  Future<void> showNotification(RemoteMessage data) async {
    var iOSPlatformSpecifics = const DarwinNotificationDetails(
        // sound: "https://www.zapsplat.com/wp-content/uploads/2015/sound-effects-84577/zapsplat_fantasy_magic_fairy_appear_ping_twinke_88657.mp3",
        );

    // todo: fix notification icon when the app in background
    var androidChannelSpecifics = AndroidNotificationDetails(
      "id",
      "name",
      channelDescription: "Description",
      importance: Importance.high,
      icon: "ic_notify",
      // sound: UriAndroidNotificationSound("https://www${data.notification?.android?.sound ?? ""}"),
      colorized: true,
      color: Colors.white,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    if (data.notification != null && Platform.isAndroid) {
      await _notificationsPlugin.show(
        0,
        data.notification!.title,
        data.notification!.body,
        notificationDetails,
      );
    }
  }

  // _downloadAndSaveFile(String url, String fileName) async {
  //   var directory = await getApplicationDocumentsDirectory();
  //   var filePath = '${directory.path}/$fileName';
  //   var response = await http.get(Uri.parse(url));
  //   var file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(alert: true, announcement: true, badge: true, sound: true);
  }

  void handlePath(Map<String, dynamic> dataMap) {
    handlePathByRoute(dataMap);
  }

  Future<void> handlePathByRoute(Map<String, dynamic> dataMap) async {
    String type = dataMap["key"].toString();
    log("--------- Global Notification Logger --------> \x1B[37m------ key -----\x1B[0m");
    log('<--------- Global Notification Logger --------> \x1B[32m $type\x1B[0m');

    // push(navigator.currentContext, NotificationView());
  }

  onSelectNotification(NotificationResponse? onSelectNotification) async {
    log("--------- Global Notification Logger --------> \x1B[37m------ payload -----\x1B[0m");
    log('<--------- Global Notification Logger --------> \x1B[32m ${onSelectNotification?.notificationResponseType}\x1B[0m');
    handlePath(_not);
  }
}


StreamController<Map<String, dynamic>> _onMessageStreamController = StreamController.broadcast();
