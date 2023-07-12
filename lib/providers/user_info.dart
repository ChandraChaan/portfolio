import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import 'package:geolocator/geolocator.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../about/about.dart';
import '../contact/contact.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../projects/projects.dart';
import '../skills/skills.dart';

class UserInfo extends ChangeNotifier {
  bool musicMode = false;
  Color themeColor = Colors.blue;
  Color oppositeColor = Colors.orange;
  String themeStringColor = '';
  String deviceId = '';
  bool themeLightMode =
      (DateTime.now().hour > 6 && DateTime.now().hour < 18) ? true : false;
  String user = 'Chandra Obul Reddy';
  String userFirstName = '';
  String imageFilterString = 'all';
  bool imageLoaded = false;
  String smallTagline =
      'Senior Software Engineer | Flutter & Flutter Web 3.0 Specialist | Building High-Performance Cross-Platform and Web Applications';
  String bigTagline =
      'Experienced Senior Software Engineer with 5.5 years of total experience, including 1.5 years of full-stack expertise and 4 years focused on Flutter development. Passionate about creating innovative mobile applications, I have successfully delivered 12+ projects across various domains. Specializing in robust e-commerce solutions, Google Maps integration, HR management systems, and educational and hospitality projects, I excel in delivering seamless user experiences, optimizing performance, and integrating complex functionalities. A collaborative problem-solver, I thrive on challenges and exceed client expectations by leveraging emerging technologies and staying up-to-date with industry trends. With strong communication and analytical skills, I translate complex requirements into actionable plans and consistently deliver results within deadlines. Committed to continuous learning and growth, I actively seek opportunities to expand my knowledge and skill set.';

  // home page properties,
  ScrollController? scrollController = ScrollController();
  final GlobalKey aboutScrollKey = GlobalKey();
  final GlobalKey expScrollKey = GlobalKey();
  final GlobalKey portfoScrollKey = GlobalKey();
  final GlobalKey skillScrollKey = GlobalKey();
  final GlobalKey projectsScrollKey = GlobalKey();
  final GlobalKey contactScrollKey = GlobalKey();

  GlobalKey scrollKeyValue(int index) {
    if (index == 0) {
      return aboutScrollKey;
    } else if (index == 1) {
      return expScrollKey;
    } else if (index == 2) {
      return portfoScrollKey;
    } else if (index == 3) {
      return skillScrollKey;
    } else if (index == 4) {
      return projectsScrollKey;
    } else {
      return contactScrollKey;
    }
  }

  // the sidebar elements
  List<Map<String, dynamic>> menuList = [
    {'name':'About', 'visibility': true, 'widget' : const About(mobileImg: true,)},
    {'name':'Experience', 'visibility': false, 'widget' : const Experience(smallCard: true,)},
    {'name':'Portfolio', 'visibility': false, 'widget' : const Portfolio(smallCard: true,)},
    {'name':'Skills', 'visibility': false, 'widget' : const Skills()},
    {'name':'Projects', 'visibility': false, 'widget' : const Projects(smallCard: true,)},
    {'name':'Contact', 'visibility': false, 'widget' : const Contact(isWeb: false,)},
  ];

  updateVisibility(int index) {
    for (int a = 0; a < menuList.length; a++) {
      if (a == index) {
        menuList[a]['visibility'] = true;
      } else {
        menuList[a]['visibility'] = false;
      }
    }
    notifyListeners();
  }

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
    roleAppUsersPut();
    notifyListeners();
  }

  changeMusicMode() {
    musicMode = !musicMode;
    roleAppUsersPut();
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
      "title": "Senior Software Developer",
      "summary":
          "As an experienced Flutter Web Developer at Softdel Systems, I specialize in responsive web design, PWAs, and Provider state management. With a strong focus on Flutter Web 3.0, I excel at creating stunning and fully responsive web designs, ensuring exceptional user experiences across various platforms. My expertise lies in implementing responsive UI solutions that seamlessly adapt to mobile, tablet, and desktop web environments. I am skilled at integrating Progressive Web App (PWA) features, allowing for offline functionality, push notifications, and an immersive user experience akin to native mobile apps. To optimize performance and maintainability, I rely on the efficient Provider state management architecture for effective state handling and communication between different components of the application. Additionally, I have successfully developed visually appealing graphs and charts, elevating data visualization and making complex information easily digestible for users. My passion for delivering exceptional Flutter Web experiences drives me to stay updated with the latest industry trends and best practices.",
      "startDate": "June 2022",
      "endDate": "",
      "present": true,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Senior Mobile App Developer",
      "summary":
          "I firmly believe that great leadership is the key to unlocking extraordinary results. As an accomplished Team Leader specializing in Flutter mobile app development, I have successfully utilized the Flutter framework, along with technologies such as Getx and Bloc, to deliver exceptional outcomes. With expertise in creating dynamic and engaging user interfaces, seamless API integration, and integration of popular payment gateways, I prioritize clean, maintainable, and scalable codebases to reduce development time and costs. I have a proven track record of delivering high-quality solutions for various platforms, including Flutter web, Android, and iOS, within tight deadlines. Collaborating with my exceptional team and leveraging the power of Flutter, we consistently achieve remarkable productivity and efficiency, driving success in our projects.",
      "startDate": "Feb 2021",
      "endDate": "June 2022",
      "present": false,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Software Developer",
      "summary":
          "I am an accomplished Full-Stack Developer with expertise in web and mobile app development. I specialize in CodeIgniter, Flutter, and RESTful APIs. Throughout my career, I have consistently delivered high-quality projects using diverse technologies. I create visually appealing and user-friendly interfaces using HTML, CSS, JavaScript, jQuery, Ajax, and Bootstrap. I develop robust and scalable web applications using CodeIgniter and expand into Flutter for cross-platform mobile app development. I excel in efficient data management with MySQL and Firebase databases, and I have a strong skillset in developing RESTful APIs for seamless communication and integration.",
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
      "score": "96%",
      "icon": "assets/skills/flutter.png",
    },
    {
      "name": "Java",
      "score": "63%",
      "icon": "assets/skills/java.png",
    },
    {
      "name": "Dart",
      "score": "98%",
      "icon": "assets/skills/dart.png",
    },
    {
      "name": "JavaScript",
      "score": "54%",
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
      "score": "51%",
      "icon": "assets/skills/python.png",
    },
    {
      "name": "PHP",
      "score": "94%",
      "icon": "assets/skills/php.png",
    },
  ];

  Map<String, dynamic> imagesMap = {
    'all': [],
    'mobile ui': [
      {
        'thumb-line': 'assets/portfolio/arrton1.png',
        'caption': 'Arrton',
        'img': [
          for (int a = 1; a <= 4; a++) 'assets/portfolio/arrton$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/arrton_d1.png',
        'caption': 'Arrton-Mobile App',
        'img': [
          for (int a = 1; a <= 3; a++) 'assets/portfolio/arrton_d$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/arrton_m1.png',
        'caption': 'Arrton-merchant App',
        'img': [
          for (int a = 1; a <= 6; a++) 'assets/portfolio/arrton_m$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/ferry1.png',
        'caption': 'Ferry App',
        'img': [
          for (int a = 1; a <= 4; a++) 'assets/portfolio/ferry$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/ppl1.png',
        'caption': 'People Platform App',
        'img': [
          for (int a = 1; a <= 6; a++) 'assets/portfolio/ppl$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/skedal1.png',
        'caption': 'Skadle App',
        'img': [
          for (int a = 1; a <= 38; a++) 'assets/portfolio/skedal$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/sunstone1.png',
        'caption': 'Sunstone App',
        'img': [
          for (int a = 1; a <= 17; a++) 'assets/portfolio/sunstone$a.png',
        ]
      },
    ],
    'PWA': [
      {
        'thumb-line': 'assets/portfolio/edecofy1.png',
        'caption': 'Edecofy',
        'img': [
          for (int a = 1; a <= 11; a++) 'assets/portfolio/edecofy$a.png',
        ]
      },
    ],
  };

  List imagesKeys = [];
  List totalImagesP = [];
  List pImages = [];

  imagesListModifying() {
    imageLoaded = false;
    imagesKeys.clear();
    pImages.clear();
    totalImagesP.clear();
    imagesKeys = imagesMap.keys.toList();
    for (int a = 0; a < imagesKeys.length; a++) {
      for (int i = 0; i < imagesMap[imagesKeys[a]].length; i++) {
        totalImagesP.add({
          'img': '${imagesMap[imagesKeys[a]][i]['thumb-line']}',
          'images': imagesMap[imagesKeys[a]][i]['img'],
          'caption': '${imagesMap[imagesKeys[a]][i]['caption']}',
          'type': '${imagesKeys[a]}'
        });
        pImages.add({
          'img': '${imagesMap[imagesKeys[a]][i]['thumb-line']}',
          'images': imagesMap[imagesKeys[a]][i]['img'],
          'caption': '${imagesMap[imagesKeys[a]][i]['caption']}',
          'type': '${imagesKeys[a]}'
        });
      }
    }
    imageLoaded = true;
    // notifyListeners();
  }

  imageFilter(String typ) {
    imageLoaded = false;
    if (imageFilterString == typ) {
      pImages.shuffle();
      print('Image filter: Shuffled the images');
    } else {
      print('Image filter: Filter type - $typ');
      if (typ == 'all') {
        pImages = List.from(totalImagesP);
        print('Image filter: Showing all images (${pImages.length} images)');
      } else {
        pImages = List.from(totalImagesP.where((o) => o['type'] == typ));
        print(
            'Image filter: Showing images of type $typ (${pImages.length} images)');
      }
    }
    imageFilterString = typ;
    imageLoaded = true;
    notifyListeners();
  }

  themeColorChange(Color cl) {
    int colorCode = cl.value;
    String colorHex =
        '0x${colorCode.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    themeColor = cl;
    themeStringColor = colorHex;
    oppositeColor = getOppositeColor(cl);
    roleAppUsersPut();
    notifyListeners();
  }

  Color getOppositeColor(Color color) {
    final int invertedRed = 255 - color.red;
    final int invertedGreen = 255 - color.green;
    final int invertedBlue = 255 - color.blue;

    return Color.fromARGB(
      color.alpha,
      invertedRed,
      invertedGreen,
      invertedBlue,
    );
  }

  int grantedPermission = 0;
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
      grantedPermission = 1;
    } else {
      // Permission denied
      grantedPermission = 2;
    }
    notifyListeners();
  }

  sendNotification({String? title, String? dec}) async {
    nLoading = true;
    if (grantedPermission == 1) {
      if (tokenFirebqse == null) {
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
                    "title": title ?? "Portfolio Showcase",
                    "body": dec ??
                        "Check out the latest additions to my portfolio! Explore my creative projects and professional work."
                  }
                }),
              )
              .then((value) => print(value.body));
        } catch (e) {}
      }
    }
    nLoading = false;
  }

  sendANotification(
      {String? title, String? dec, required String fbaseToken}) async {
    nLoading = true;

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
              'to': fbaseToken.toString(),
              'message': {
                'token': fbaseToken.toString(),
              },
              "notification": {
                "title": title ?? "Portfolio Showcase",
                "body": dec ??
                    "Check out the latest additions to my portfolio! Explore my creative projects and professional work."
              }
            }),
          )
          .then((value) => print(value.body));
    } catch (e) {}

    nLoading = false;
  }

  String address = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String systemName = '';
  String browserName = '';

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;

    final addressloc = await getAddress(latitude, longitude);

    address = addressloc;
  }

  Future<String> getAddress(double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      final address = decodedData['display_name'];
      return address;
    }

    return 'Address not found';
  }

  getSystemName() {
    systemName = html.window.navigator.platform!;
  }

  getBrowserName() {
    String userAgent = html.window.navigator.userAgent;

    if (userAgent.contains('Chrome')) {
      browserName = 'Chrome';
    } else if (userAgent.contains('Firefox')) {
      browserName = 'Firefox';
    } else if (userAgent.contains('Safari')) {
      browserName = 'Safari';
    } else if (userAgent.contains('Opera') || userAgent.contains('OPR')) {
      browserName = 'Opera';
    } else if (userAgent.contains('Edge')) {
      browserName = 'Edge';
    } else if (userAgent.contains('MSIE') || userAgent.contains('Trident/')) {
      browserName = 'Internet Explorer';
    } else {
      browserName = userAgent;
    }
  }

  final Connectivity _connectivity = Connectivity();

  String chargingStatus = 'Unknown';
  String wifiNetworkTypeLoc = 'Unknown';

  Future<void> getBatteryLevel() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;

    chargingStatus = '$batteryLevel';
  }

  Future<void> getWifiNetworkType() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      const wifiNetworkType = 'Connected';

      wifiNetworkTypeLoc = wifiNetworkType;
    } else {
      const wifiNetworkType = 'Not connected';

      wifiNetworkTypeLoc = wifiNetworkType;
    }
  }

  // api call

  int getColorFromColorRepresentation(String colorRepresentation) {
    // Remove unnecessary parts from the string
    String colorValueString =
        colorRepresentation.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');

    // Convert the color value string to an integer
    int colorValue = int.parse(colorValueString, radix: 16);

    // Create and return the Color object
    return colorValue;
  }

  Future<void> roleAppUsersPost() async {
    final tokenFcmF = tokenFirebqse;
    final browserNameF = browserName;
    final systemNameF = systemName;
    final addressF = address;

    final collectionRef = FirebaseFirestore.instance.collection('visiters');

    if (tokenFcmF != null && tokenFcmF.isNotEmpty) {
      final querySnapshot =
          await collectionRef.where('token_fcm', isEqualTo: tokenFcmF).get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingRecord = querySnapshot.docs.first;

        final data = {
          'system_name': systemNameF,
          'browser_name': browserNameF,
          'address': addressF,
          'token_fcm': tokenFcmF,
          'battery': chargingStatus,
          'wifi': wifiNetworkTypeLoc,
          'sound': musicMode ? 'true' : 'false',
          'dark_theme': themeLightMode ? 'false' : 'true',
          'color_theme': themeStringColor,
          'seen_chat_screen': '0',
          'seen_full_resume': '0',
          'date': DateTime.now().toString()
        };

        await existingRecord.reference.update(data);

        final updatedRecordSnapshot = await existingRecord.reference.get();
        deviceId = updatedRecordSnapshot.id;
      } else {
        final data = {
          'system_name': systemNameF,
          'browser_name': browserNameF,
          'token_fcm': tokenFcmF,
          'address': addressF,
          'battery': chargingStatus,
          'wifi': wifiNetworkTypeLoc,
          'sound': musicMode ? 'true' : 'false',
          'dark_theme': themeLightMode ? 'false' : 'true',
          'color_theme': themeStringColor,
          'seen_chat_screen': '0',
          'seen_full_resume': '0',
          'date': DateTime.now().toString()
        };

        final newDocumentRef = await collectionRef.add(data);
        final newDocumentSnapshot = await newDocumentRef.get();
        deviceId = newDocumentSnapshot.id;
      }
    }
    notifyListeners();
  }

  Future<void> roleAppUsersPut() async {
    final id = deviceId;

    final collectionRef = FirebaseFirestore.instance.collection('visiters');
    final documentSnapshot = await collectionRef.doc(id).get();
    if (documentSnapshot.exists) {
      final existingRecord = documentSnapshot.reference;
      final data = {
        'system_name': systemName,
        'browser_name': browserName,
        'token_fcm': tokenFirebqse,
        'address': address,
        'battery': chargingStatus,
        'wifi': wifiNetworkTypeLoc,
        'sound': '$musicMode'.toString(),
        'dark_theme': '${!themeLightMode}'.toString(),
        'color_theme': themeStringColor,
        'seen_chat_screen': '0',
        'seen_full_resume': '0',
        'date': DateTime.now().toString()
      };

      await existingRecord.update(data);
    }
    notifyListeners();
  }

  // Future<void> postData() async {
  //   const apiUrl = 'https://chandrachaan.in/randac/item/role_app_users';
  //   final requestBody = {
  //     'system_name': systemName,
  //     'browser_name': browserName,
  //     'token_fcm': '$tokenFirebqse'.toString(),
  //     'address': address,
  //     'battery': chargingStatus,
  //     'wifi': wifiNetworkTypeLoc,
  //     'sound': '$musicMode'.toString(),
  //     'dark_theme': '${!themeLightMode}'.toString(),
  //     'color_theme': '$themeColor'.toString(),
  //     'seen_chat_screen': '',
  //     'seen_full_resume': '',
  //   };
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonData = json.decode(response.body);
  //       Map<String, dynamic> apiResponse = jsonData['data'];
  //       Color tcolor =
  //           getColorFromColorRepresentation(apiResponse['color_theme']);
  //       deviceId = apiResponse['id'];
  //       musicMode = apiResponse['sound'].toString() == '0' ? false : true;
  //       themeLightMode =
  //           apiResponse['dark_theme'].toString() == '0' ? true : false;
  //       themeColor = tcolor;
  //     } else {
  //       // Request failed
  //     }
  //   } catch (e) {
  //     // Exception occurred during API call
  //   }
  //   notifyListeners();
  // }
  //
  // Future<void> updateData() async {
  //   const apiUrl = 'https://chandrachaan.in/randac/item/role_app_users';
  //   final requestBody = {
  //     'id': deviceId,
  //     'system_name': systemName,
  //     'browser_name': browserName,
  //     'token_fcm': '$tokenFirebqse'.toString(),
  //     'address': address,
  //     'battery': chargingStatus,
  //     'wifi': wifiNetworkTypeLoc,
  //     'sound': '$musicMode'.toString(),
  //     'dark_theme': '${!themeLightMode}'.toString(),
  //     'color_theme': '$themeColor'.toString(),
  //     'seen_chat_screen': '',
  //     'seen_full_resume': '',
  //   };
  //   try {
  //     final response = await http.put(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //     if (response.statusCode == 200) {
  //     } else {
  //       // Request failed
  //     }
  //   } catch (e) {
  //     // Exception occurred during API call
  //   }
  //   notifyListeners();
  // }

  void setToken(String? token) {
    insertToeken(token);
  }

  Stream<String>? _tokenStream;

  void getToken() {
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen(setToken);
  }

  initFun() async {
    await getPermission();
    getToken();
    await getUserLocation();
    await getSystemName();
    await getBrowserName();
    await getBatteryLevel();
    await getWifiNetworkType();
    roleAppUsersPost();
  }
}
