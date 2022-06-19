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
    } else if (Platform.isIOS) {
      await storage.write(key: 'DeviceName', value: 'ios');
    }
  } on PlatformException {
    debugPrint("failed to get platform");
  }
}

Future<void> fcmToken(tokenFcm) async {
  final storage = new FlutterSecureStorage();
  String? messageToken = await FirebaseMessaging.instance.getToken();
  tokenFcm = messageToken;
  debugPrint("FCM token:${messageToken}");
  await storage.write(key: 'fcmToken', value: messageToken);
}
