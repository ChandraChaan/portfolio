import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfo extends ChangeNotifier {
  bool musicMode = false;
  Color themeColor = Colors.blue;
  bool themeLightMode =
      (DateTime.now().hour > 6 && DateTime.now().hour < 18) ? true : false;
  String user = 'Chandra Obul Reddy';
  String userFirstName = '';
  String imageFilterString = 'all';
  bool imageLoaded = false;
  String smallTagline =
      'THE NEXT BIG IDEA IS WAITING FOR ITS NEXT BIG CHANGER WITH THEMSELF';
  String bigTagline = 'I have a total of around 5.3 years of experience,'
      'recently, with FLUTTER, I\'m developed multiple projects. I believe my'
      'professional skill set and my previous experience working as a Full-Stack and'
      'senior flutter developer could make me a valuable asset to your organization,'
      ' so I am writing to inform you of my interest in pursuing a career at org name';

  bool userDeatile(String? text) {
    user = text ?? 'User';
    if (user.split(' ').length > 1) {
      return false;
    } else {
      return true;
    }
  }

  changeThemeMode() {
    themeLightMode = !themeLightMode;
    notifyListeners();
  }

  changeMusicMode() {
    musicMode = !musicMode;
    notifyListeners();
  }

  // it will remove last name for highlighting it on UI
  removeLastNameOnUser() {
    List name = user.split(' ');

    if (name.length > 1) {
      name.removeRange(name.length - 1, name.length);
      userFirstName = name.join(' ');
    }
    userFirstName = name.join(' ');
  }

  List<Map<String, dynamic>> expData = [
    {
      "icon": Icons.laptop_outlined,
      "title": "Senior Mobile App Developer",
      "summary": "Here I am team lead, we are working on sprint wise features, and DDD"
          "architecture and GetX, Bloc, providers state management we are using. Kotlin"
          "  for android native payment integration purpose we are used. Swift for IOS"
          "Native feature development we are used.",
      "startDate": "Feb 2021",
      "endDate": "",
      "present": true,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Software Developer",
      "summary": "I'm Full Stack developer at this company and"
          "We are using framework CodeIgniter, PHP frameworks for backend, and we"
          "are using for mobile development in flutter, and we are using jQuery, JS,"
          "bootstrap for frontend."
          "This is product base company"
          "Maintained integrity of general ledger, including the chart of accounts",
      "startDate": "Feb 2018",
      "endDate": "Jan 2021",
      "present": false,
    },
  ];

  List<Map<String, dynamic>> projectsData = [
    {
      'title': 'Lochinvar',
      'date': 'Jun 2022',
      'summary':
          'This is boiler app , using this app, we can control the boiler from everywhere, this is very use full app, here iam doing Kotlin app to flutter app conversation for Web and Mobile hybrid code, here I used flutter and provider state management.'
    },
    {
      'title': 'Sunstone hub',
      'date': 'Jan 2022',
      'summary':
          'This is University app, there students will do attendance, and books, fees etc I developed here fee module. With Getx state management, flutter.'
    },
    {
      'title': 'People first Platform',
      'date': 'February 2021',
      'summary':
          'Here we are using DDD architecture with Getx, bloc, and cubit, in that architecture infrastructure'
              'domain, application presentation layers we maintain here, and network layer also.'
    },
    {
      'title': 'Ferry App',
      'date': 'April 2021',
      'summary':
          'Here common network Layer I’m using here and it will show you the check-in process for airplane journey users.'
    },
    {
      'title': 'EstreetMart - Singapore online shopping website',
      'date': 'May 2021',
      'summary':
          'Here I’m using DDD architecture with GetX, and this is the web, tablet, mobile, and desktop also'
              'multiple designs with the same functionality and this is a large project here IMS, CMS, and this one is there.'
    },
    {
      'title': 'Skadaddle Online Sports activity App',
      'date': 'June 2021',
      'summary':
          'Here I’m using DDD architecture with GetX, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'RandAc app - Online Book Technician for AC Repairing',
      'date': 'September 2021',
      'summary':
          'This is an ac repairing app, this is currently what we are developing Here I’m using DDD architecture with Getx, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'GastroCare -Online Doctor consultation Booking App',
      'date': 'August 2021',
      'summary':
          'This is a Medical app, this is currently we are developing Here I’m using Bloc, Providers, this is a mobile app here we are used zoom video calling functionality for doctor consultation.'
    },
    {
      'title': 'Plus Pin Pharma -Online Medical Store',
      'date': 'August 2021',
      'summary':
          'This is a Medical Store app, this is currently 3members are developing Here I’m using MVC architecture with Bloc and GetX, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'Food Delivery App',
      'date': 'February 2020',
      'summary': 'This is a food delivery app using flutter.'
    },
    {
      'title': 'Online shopping web & mobile application',
      'date': 'January 2019',
      'summary':
          'This is a flutter platform-based online shopping service, food, clothes, and etc. so many services are there, for the web, we are using PHP Laravel and fronted bootstrap, jQuery.'
    },
    {
      'title': 'School management system',
      'date': 'May 2019',
      'summary':
          'It is a flutter Mobile application. This application is very useful for schools, This application has a fee management system and HR and payroll and online classes and online exams and so many services there,'
    },
  ];

  List<Map<String, dynamic>> skillData = [
    {
      "name": "Flutter",
      "score": "100%",
      "icon": "assets/skills/flutter.png",
    },
    {
      "name": "Java",
      "score": "80%",
      "icon": "assets/skills/java.png",
    },
    {
      "name": "Dart",
      "score": "100%",
      "icon": "assets/skills/dart.png",
    },
    {
      "name": "JavaScript",
      "score": "94%",
      "icon": "assets/skills/js.png",
    },
    {
      "name": "HTML",
      "score": "74%",
      "icon": "assets/skills/html.png",
    },
    {
      "name": "CSS",
      "score": "61%",
      "icon": "assets/skills/css.png",
    },
    {
      "name": "FIREBASE",
      "score": "74%",
      "icon": "assets/skills/firebase.png",
    },
    {
      "name": "PYTHON",
      "score": "84%",
      "icon": "assets/skills/python.png",
    },
    {
      "name": "PHP",
      "score": "94%",
      "icon": "assets/skills/php.png",
    },
  ];

  Map imagesMap = {
    'all': [],
    'ui': [
      'assets/portfolio/chandra/arrton1.png',
      'assets/portfolio/chandra/arrton2.png',
      'assets/portfolio/chandra/arrton3.png',
    ],
  };
  List imagesKeys = [];
  List pImages = [];

  imagesListModifiying() {
    imageLoaded = false;
    imagesKeys.clear();
    pImages.clear();
    imagesKeys = imagesMap.keys.toList();
    for (int a = 0; a < imagesKeys.length; a++) {
      for (int i = 0; i < imagesMap[imagesKeys[a]].length; i++) {
        pImages.add({
          'img': '${imagesMap[imagesKeys[a]][i]}',
          'type': '${imagesKeys[a]}'
        });
      }
    }
    imageLoaded = true;
  }

  imageFilter(String typ) {
    imageLoaded = false;
    print('add filter to $typ');
    imageFilterString = typ;
    pImages = pImages.where((o) => o['type'] == typ).toList();
    imageLoaded = true;
    notifyListeners();
  }

  themeColorChange(Color cl) {
    themeColor = cl;
    notifyListeners();
  }

  bool grantedPermission = false;
  bool nLoading = false;
  String? tokenFirebqse;

  insertToeken(String? tok) {
    tokenFirebqse = tok;
    notifyListeners();
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      grantedPermission = true;
    } else {
      // Permission denied
      print('Web push permission denied');
      grantedPermission = false;
    }
    notifyListeners();
  }

  sendNotification() async {
    nLoading = true;
    if (grantedPermission) {
      if (tokenFirebqse == null) {
        print('Unable to send FCM message, no token exists.');
        return;
      } else {
        try {
          await http
              .post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization':
                      'key=AAAAy2Awy5M:APA91bHy0D-kVL7hR5vWL8M_56uxq_gpSPP6H29Ez7Goi7wIgm9Q1wGQSaE-fbVyF8F76vmfo1-gXYHVLh0TLW5wt5cgokJApoG2yCxf8qXXWhug_nY6HUrWzrmNk1QKhIq_Ebdme_d_'
                },
                body: json.encode({
                  'to': tokenFirebqse.toString(),
                  'message': {
                    'token': tokenFirebqse.toString(),
                  },
                  "notification": {
                    "title": "Portfolio Showcase",
                    "body":
                        "Check out the latest additions to my portfolio! Explore my creative projects and professional work."
                  }
                }),
              )
              .then((value) => print(value.body));
          print('FCM request for web sent!');
        } catch (e) {
          print(e);
        }
      }
    }
    else {

      getPermission();
      print('Web push permission denied');
    }
    nLoading = false;
  }
}
