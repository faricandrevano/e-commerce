import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kelompok9_toko_online/helper/flutter_notification.dart';

class Fcm {
  static Map<String, dynamic> tryDecode(data) {
    try {
      return jsonDecode(data);
    } catch (e) {
      return {};
    }
  }

  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM TOKEN: $fcmToken");
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      HelperNotification.payload.value = jsonEncode({
        "title": value?.notification?.title,
        "body": value?.notification?.body,
        "data": value?.data
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((value) {
      HelperNotification.payload.value = jsonEncode({
        "title": value.notification?.title,
        "body": value.notification?.body,
        "data": value.data
      });
    });
    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        await HelperNotification.flutterLocalNotificationsPlugin.show(
            Random().nextInt(99),
            notification.title,
            notification.body,
            payload: jsonEncode({
              "title": notification.title,
              "body": notification.body,
              "data": message.data
            }),
            HelperNotification.notificationDetails);
      }
    });
  }
}
