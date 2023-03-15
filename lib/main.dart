import 'package:flutter/material.dart';
import 'package:originalmorals/providers/user_info.dart';
import 'package:originalmorals/scrollnavigation_screen.dart';
import 'package:originalmorals/skills/Skills.dart';
import 'package:provider/provider.dart';

import 'about/about.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => UserInfo())),
      ],
      child: MaterialApp(
        title: 'portfolio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
