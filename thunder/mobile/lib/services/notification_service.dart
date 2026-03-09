import "package:firebase_messaging/firebase_messaging.dart";

class NotificationService {
  Future<String?> initAndGetToken() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    return messaging.getToken();
  }
}
