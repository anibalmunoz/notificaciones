import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// sha1 = "F8:A0:8A:44:B9:6D:FA:59:F1:8E:8A:FF:4E:73:03:F1:6E:B2:31:E2";

class PushNotificationService {
  static final firebaseMessagin = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get mesageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _manageData(message);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _manageData(message);
  }

  static Future _onMessageOpenAppHandler(RemoteMessage message) async {
    _manageData(message);
  }

  static _manageData(RemoteMessage message) {
    _messageStream.add(message.data["product"] ?? "No_data");
    print(message.data);
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppHandler);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
