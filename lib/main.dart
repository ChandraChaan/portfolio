import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/push_notifications.dart';
import 'invitation_srceen/invitation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCcyArg2tLT6FgAIvfe_mU2Q1DAzGC1gD4",
      appId: "1:873492171667:web:f210c8d97d4b34f169b666",
      messagingSenderId: "873492171667",
      projectId: "rollapp123-6b732",
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfo>(
      create: (_) => UserInfo(),
      child: const RoleApp(),
    );
  }
}

class RoleApp extends StatelessWidget {
  const RoleApp({super.key});

  ThemeData _buildThemeData(UserInfo themeMode) {
    return ThemeData(
      typography: Typography.material2018(
        englishLike: Typography.englishLike2018,
        dense: Typography.dense2018,
        tall: Typography.tall2018,
      ),
      primaryColor: themeMode.themeLightMode ? Colors.black : Colors.white,
      indicatorColor: themeMode.themeColor,
      focusColor: themeMode.oppositeColor,
      cardColor: themeMode.themeLightMode ? Colors.white : Colors.black,
      backgroundColor: themeMode.themeLightMode ? Colors.white : Colors.black,
      // colorScheme: ColorScheme(background: themeMode.themeLightMode ? Colors.white : Colors.black, brightness: Brightness., primary: null, onPrimary: null, secondary: null, onSecondary: null, error: null, onError: null, onBackground: null, surface: null, onSurface: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<UserInfo>(context);
    return MaterialApp(
      title: 'Curriculum Vitae',
      theme: _buildThemeData(themeMode),
      debugShowCheckedModeBanner: false,
      home: const PushNotificationApp(),
    );
  }
}
