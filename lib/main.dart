import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'animation_route/gaming_page.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCcyArg2tLT6FgAIvfe_mU2Q1DAzGC1gD4",
      appId: "1:873492171667:web:f210c8d97d4b34f169b666",
      messagingSenderId: "873492171667",
      projectId: "rollapp123-6b732",
    ),
  );
  return runApp(ChangeNotifierProvider<UserInfo>(
    create: (_) => UserInfo(),
    child: const RoleApp(),
  ));
}

class RoleApp extends StatelessWidget {
  const RoleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<UserInfo>(context);
    return MaterialApp(
      title: 'Curriculum Vitae',
      theme: ThemeData(
        primaryColor: themeMode.themeLightMode ? Colors.black : Colors.white,
        // primarySwatch: themeMode.themeColor,
        indicatorColor: themeMode.themeColor,
        backgroundColor: themeMode.themeLightMode ? Colors.white : Colors.black,
        cardColor: themeMode.themeLightMode ? Colors.white : Colors.black,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// Entry point for the example application.
class PushNotificationApp extends StatefulWidget {
  static const routeName = "/firebase-push";

  const PushNotificationApp({super.key});

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    getPermission();
    messageListener(context);
    super.initState();
  }

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
          print('android firebase initiated');
          return HomePage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.body}');
        AwesomeDialog(
                context: context,
                width: MediaQuery.of(context).size.width / 2,
                animType: AnimType.topSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                title: message.notification?.title,
                desc: message.notification?.body,
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDismissCallback: (v) {})
            .show();
        // showDialog(
        //     context: context,
        //     builder: ((BuildContext context) {
        //       return DynamicDialog(
        //           title: message.notification?.title,
        //           body: message.notification?.body);
        //     }));
      }
    });
  }
}

//push notification dialog for foreground
class DynamicDialog extends StatefulWidget {
  final title;
  final body;

  const DynamicDialog({this.title, this.body});

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}
