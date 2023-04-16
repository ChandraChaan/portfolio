import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'about/about.dart';
import 'home_page.dart';

// import 'local_pushnotifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
        ),

        NotificationChannel(
            channelGroupKey: 'image_test',
            channelKey: 'image',
            channelName: 'image notifications',
            channelDescription: 'Notification channel for image tests',
            defaultColor: Colors.redAccent,
            ledColor: Colors.white,
            channelShowBadge: true,
            importance: NotificationImportance.High
        )

        //add more notification type with different configuration

      ]
  );


  runApp(const RoleApp());
}



class RoleApp extends StatelessWidget {
  const RoleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder : (context,orientation, deviceType){

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => UserInfo())),
      ],
      child: MaterialApp(
        title: 'Curriculum Vitae',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  });
  }
}
