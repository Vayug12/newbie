import "dart:developer";
import "package:firebase_messaging/firebase_messaging.dart";

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<String?> initialization() async {
    // 1. Request Permission
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted permission");
    } else {
      log("User declined or has not accepted permission");
    }

    // 2. Get Token
    String? token = await _fcm.getToken();
    log("FCM Token: $token");

    // 3. Handle Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Got a message whilst in the foreground!");
      log("Message data: ${message.data}");

      if (message.notification != null) {
        log("Message also contained a notification: ${message.notification?.title}");
        // You could show a local notification here if needed
      }
    });

    // 4. Handle Background Messages (Opened via Notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("App opened from notification: ${message.notification?.title}");
    });

    return token;
  }
}

