import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fcm_mobile/utils.dart';

FirebaseMessaging _firebaseMessaging;

Future<void> initFcm() async {
  _firebaseMessaging = FirebaseMessaging();
  await _firebaseMessaging.requestNotificationPermissions();
  _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler);

  // register the fcm token to the backend
  final deviceToken = await _firebaseMessaging.getToken();
  print(deviceToken);

  // hit the api
  final urlPath = 'http://10.0.2.2:8000/devices/';
  final data = {
    "registration_id": deviceToken,
    "type": 'android',
  };
  final headers = {'Authorization': 'jwt $globalToken'};

  final resp =
      await dio.post(urlPath, data: data, options: Options(headers: headers));

  print('ok');
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
