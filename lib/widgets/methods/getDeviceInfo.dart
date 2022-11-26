import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> getDeviceDetails() async {
  final storage = new FlutterSecureStorage();
  try {
    if (Platform.isAndroid) {
      await storage.write(key: 'DeviceName', value: "android");
       debugPrint("Device: ANROID");
    } else if (Platform.isIOS) {
      await storage.write(key: 'DeviceName', value: 'ios');
      debugPrint("Device: IOS");
    }
  } on PlatformException {
    debugPrint("failed to get platform");
  }
}

Future<void> fcmToken() async {
  final storage = new FlutterSecureStorage();
  String? messageToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM token:${messageToken}");
  await storage.write(key: 'fcmToken', value: messageToken);
}

    String capitalizeAllWord(String value) {
      var result = value[0].toUpperCase();
      for (int i = 1; i < value.length; i++) {
        if (value[i - 1] == " ") {
          result = result + value[i].toUpperCase();
        } else {
          result = result + value[i];
        }
      }
      return result;
    }