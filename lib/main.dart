import 'package:flutter/material.dart';
import 'package:portfoli_web/core/home_page.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/push_notifications.dart';

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
        typography: Typography.material2018(
          englishLike: Typography.englishLike2018,
          dense: Typography.dense2018,
          tall: Typography.tall2018,
        ),
        primaryColor: themeMode.themeLightMode ? Colors.black : Colors.white,
        indicatorColor: themeMode.themeColor,
        focusColor: themeMode.oppositeColor,
        backgroundColor: themeMode.themeLightMode ? Colors.white : Colors.black,
        cardColor: themeMode.themeLightMode ? Colors.white : Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: const PushNotificationApp(),
    );
  }
}

