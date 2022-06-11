import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:luxpay/podos/notifications.dart';
import 'package:luxpay/services/notification_database.dart';

import '../views/notifications/notificationsPage.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: initializationSettingsIOS);

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      if (route != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationPage()));
        print(" Route Navigate to $route");
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "easyapproach",
        "easyapproach channel",
        importance: Importance.max,
        priority: Priority.high,
      ));
      addNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          date: DateTime.now());
      debugPrint("local notification:${message.notification!.body}");
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future addNotification({title, body, date}) async {
  final notification = Notifications(
    title: title,
    body: body,
    createdTime: date,
  );

  var data = await NotificationDatabase.instance.create(notification);
  print("Notification data:${data}");
}
