import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
      home: const PushNotificationApp(),
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
    // updateDta();
    Provider.of<UserInfo>(context, listen: false).initFun();
    print('message listener running');
    messageListener(context);
    super.initState();
  }

  // updateDta() async {
  //   final CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('visiters');
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
            print('android firebase initiated');
          return const HomePage();
          // return Secondpage(hideBackButton: true,);
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
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.body}');
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

//push notification dialog for foreground

class NotificationDialog extends StatefulWidget {
  final String title;
  final String message;

  const NotificationDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: -0.15, end: 0.15).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: _animation.value,
                  child: Icon(
                    Icons.notifications_active_sharp,
                    color: Theme.of(context).indicatorColor,
                    size: 48.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .indicatorColor, // Change the button color here
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
