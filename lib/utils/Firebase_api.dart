import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {

  final firebaseMessaging= FirebaseMessaging.instance;

   Future<void> intnotifiactions() async {
    await firebaseMessaging.requestPermission();
    final FCMToken = await firebaseMessaging.getToken();
    print("Token ==========>: $FCMToken");
    FirebaseMessaging.onBackgroundMessage((message)async{
       print("title: ${message.notification?.title}");
       print("body: ${message.notification?.body}");
       print("paylod: ${message.data}");

    });
  }


}