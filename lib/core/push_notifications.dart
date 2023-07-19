import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/chat_game/chat_mini_game.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../admin/admin_screen.dart';
import 'home_page.dart';
import '../providers/user_info.dart';
import '../utils/notification_dailog.dart';

class PushNotificationApp extends StatefulWidget {
  static const routeName = "/firebase-push";

  const PushNotificationApp({super.key});

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    // updateDta();
    Provider.of<UserInfo>(context, listen: false).initFun();
    if (kDebugMode) {
      print('message listener running');
    }
    messageListener(context);
    super.initState();
  }

  // updateDta() async {
  //   final CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('visitors');
  //   final QuerySnapshot snapshot = await collectionRef.get();
  //   for (final DocumentSnapshot doc in snapshot.docs) {
  //     await collectionRef.doc(doc.id).update({
  //       'dark_theme': 'true',
  //       'sound': 'true',
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (kDebugMode) {
            print('android firebase initiated');
          }
          return ChatGame(hideBackButton: true);
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }
      if (message.notification != null) {
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification?.body}');
        }
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return NotificationDialog(
                  title: (message.notification?.title).toString(),
                  message: (message.notification?.body).toString());
            }));
      }
    });
  }
}
