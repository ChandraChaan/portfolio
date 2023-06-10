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

class UserInfo extends ChangeNotifier {
  bool musicMode = false;
  Color themeColor = Colors.blue;
  String themeStringColor = '';
  String deviceId = '';
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
    imageFilterString = typ;
    pImages = pImages.where((o) => o['type'] == typ).toList();
    imageLoaded = true;
    notifyListeners();
  }

  themeColorChange(Color cl) {

    int colorCode = cl.value;
    String colorHex = '0x${colorCode.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    themeColor = cl;
    themeStringColor = colorHex;
    roleAppUsersPut();
    notifyListeners();
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
      }
      else {
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
        } catch (e) {
        }
      }
    }
    nLoading = false;
  }

  sendANotification({String? title, String? dec, required String fbaseToken}) async {
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
        } catch (e) {
        }

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

  final Battery _battery = Battery();
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
    final tokenFcm_f = tokenFirebqse;
    final browserName_f = browserName;
    final systemName_f = systemName;
    final address_f = address;

    final collectionRef = FirebaseFirestore.instance.collection('visiters');

    if (tokenFcm_f != null && tokenFcm_f.isNotEmpty) {
      final querySnapshot = await collectionRef.where('token_fcm', isEqualTo: tokenFcm_f).get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingRecord = querySnapshot.docs.first;

        final data = {
          'system_name': systemName_f,
          'browser_name': browserName_f,
          'address': address_f,
          'token_fcm': tokenFcm_f,
          'battery': chargingStatus,
          'wifi': wifiNetworkTypeLoc,
          'sound': musicMode ? 'true' : 'false',
          'dark_theme': themeLightMode ? 'false' : 'true',
          'color_theme': themeStringColor,
          'seen_chat_screen': '0',
          'seen_full_resume': '0',
          'date':DateTime.now().toString()
        };

        await existingRecord.reference.update(data);

        final updatedRecordSnapshot = await existingRecord.reference.get();
        final updatedRecord = updatedRecordSnapshot.data();
        // Map<String, dynamic> updatedRecord = updatedRecordSnapshot.data() as Map<String, dynamic>;
        deviceId = updatedRecordSnapshot.id;

        final response = {
          'status': 'success',
          'message': 'Data updated successfully',
          'data': updatedRecord,
        };
        print('device id $deviceId');
       // print(response.toString());

      }
      else {

        final data = {
          'system_name': systemName_f,
          'browser_name': browserName_f,
          'token_fcm': tokenFcm_f,
          'address': address_f,
          'battery': chargingStatus,
          'wifi': wifiNetworkTypeLoc,
          'sound': musicMode ? 'true' : 'false',
          'dark_theme': themeLightMode ? 'false' : 'true',
          'color_theme': themeStringColor,
          'seen_chat_screen':'0',
          'seen_full_resume': '0',
          'date': DateTime.now().toString()
        };

        final newDocumentRef = await collectionRef.add(data);
        final newDocumentSnapshot = await newDocumentRef.get();
        final newRecord = newDocumentSnapshot.data();
        deviceId = newDocumentSnapshot.id;
        final response = {
          'status': 'success',
          'message': 'Data inserted successfully',
          'data': newRecord,
        };

        print('device id $deviceId');
      }
    }
    notifyListeners();
  }

  Future<void> roleAppUsersPut() async {
    final id = deviceId;

    final collectionRef = FirebaseFirestore.instance.collection('visiters');
    final documentSnapshot = await collectionRef.doc(id).get();
    print('the id have data');
    print(documentSnapshot.data());
    if (documentSnapshot.exists) {
      final existingRecord = documentSnapshot.reference;
      print('the id have data step 3');
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
        'seen_chat_screen':'0',
        'seen_full_resume': '0',
        'date':DateTime.now().toString()
      };

      await existingRecord.update(data);
      print('the id have data step 4');
      final response = {
        'status': 'success',
        'message': 'Data updated successfully',
        'data': data,
      };

      print(response.toString());
      print('the id have data step 5');
    } else {
      final response = {
        'status': 'error',
        'message': 'Record does not exist',
        'data': null,
      };

      print(response.toString());
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
    print('FCM TokenToken: $token');
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
