import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/chat_game/chat_mini_game.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../providers/user_info.dart';
import 'dart:html' as html;

class PushNotificationApp extends StatefulWidget {
  static const routeName = "/firebase-push";

  const PushNotificationApp({super.key});

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    // removeAllDataFromVisitors();
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


  // Future<void> removeAllDataFromVisitors() async {
  //   final firestore = FirebaseFirestore.instance;
  //
  //   // Fetch all documents from the 'visitors' collections
  //   final QuerySnapshot allDocs = await firestore.collection('visitors').get();
  //
  //   // Check if there are any documents to delete
  //   if (allDocs.docs.isEmpty) {
  //     print("No documents found in the 'visitors' collection.");
  //     return;
  //   }
  //
  //   print("Found ${allDocs.docs.length} documents in the 'visitors' collection.");
  //
  //   for (final QueryDocumentSnapshot document in allDocs.docs) {
  //     // Printing the ID of the document being deleted (optional)
  //     print("Deleting document with ID: ${document.id}");
  //
  //     // Delete the document
  //     await firestore.collection('visitors').doc(document.id).delete();
  //   }
  //
  //   print("All documents in the 'visitors' collection have been deleted.");
  // }


  @override
  Widget build(BuildContext context) {
    return const ChatGame(hideBackButton: true);
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (html.Notification.permission == "granted") {
          showWebNotification(message.notification!);
        } else if (html.Notification.permission != "denied") {
          html.Notification.requestPermission().then((permission) {
            if (permission == "granted") {
              showWebNotification(message.notification!);
            }
          }).catchError((error) {
            print('Error requesting notification permissions: $error');
          });
        } else {
          print('Notification permission has been denied. Please enable it from browser settings.');
        }
      }
    });
  }

  void showWebNotification(RemoteNotification notification) {
    try {
      var webNotification = html.Notification(notification.title.toString(), body: notification.body);
    } catch (error) {
      print('Error showing web notification: $error');
    }
  }

}
