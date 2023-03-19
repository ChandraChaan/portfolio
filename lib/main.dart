import 'package:flutter/material.dart';
import 'package:originalmorals/about/about.dart';
import 'package:originalmorals/providers/user_info.dart';
// import 'package:originalmorals/scrollnavigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main()  {

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder : (context,orientation, deviceType){

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => UserInfo())),
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: About(),
      ),
    );
  });
  }
}
