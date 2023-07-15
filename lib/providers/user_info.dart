import 'dart:js';

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
import '../animation_route/navigate_newpage.dart';
import '../chat_game/message_domain.dart';
import '../contact/contact.dart';
import '../core/home_page.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../projects/projects.dart';
import '../skills/skills.dart';
import '../utils/constants.dart';
import '../utils/getReplayList.dart';

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

  // home page properties,
  ScrollController? scrollController = ScrollController();
  final GlobalKey aboutScrollKey = GlobalKey();
  final GlobalKey expScrollKey = GlobalKey();
  final GlobalKey portfoScrollKey = GlobalKey();
  final GlobalKey skillScrollKey = GlobalKey();
  final GlobalKey projectsScrollKey = GlobalKey();
  final GlobalKey contactScrollKey = GlobalKey();

  List<Map<String, dynamic>> menuList = [
    {
      'name': 'About',
      'visibility': true,
    },
    {
      'name': 'Experience',
      'visibility': false,
    },
    {
      'name': 'Portfolio',
      'visibility': false,
    },
    {
      'name': 'Skills',
      'visibility': false,
    },
    {
      'name': 'Projects',
      'visibility': false,
    },
    {
      'name': 'Contact',
      'visibility': false,
    },
  ];

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

  updateVisibility(int index) {
    print('the index was called $index');
    for (int a = 0; a < menuList.length; a++) {
      if (a == index) {
        menuList[a]['visibility'] = true;
        print('the index was updated ${menuList[a]['visibility']}');
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

  List imagesKeys = [];
  List totalImagesP = [];
  List pImages = [];

  imagesListModifying() {
    imageLoaded = false;
    imagesKeys.clear();
    pImages.clear();
    totalImagesP.clear();
    imagesKeys = Constants.imagesMap.keys.toList();
    for (int a = 0; a < imagesKeys.length; a++) {
      for (int i = 0; i < Constants.imagesMap[imagesKeys[a]].length; i++) {
        totalImagesP.add({
          'img': '${Constants.imagesMap[imagesKeys[a]][i]['thumb-line']}',
          'images': Constants.imagesMap[imagesKeys[a]][i]['img'],
          'caption': '${Constants.imagesMap[imagesKeys[a]][i]['caption']}',
          'type': '${imagesKeys[a]}'
        });
        pImages.add({
          'img': '${Constants.imagesMap[imagesKeys[a]][i]['thumb-line']}',
          'images': Constants.imagesMap[imagesKeys[a]][i]['img'],
          'caption': '${Constants.imagesMap[imagesKeys[a]][i]['caption']}',
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
    notifyListeners();
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
    // notifyListeners();
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
    notifyListeners();
  }

  final Connectivity _connectivity = Connectivity();

  String chargingStatus = 'Unknown';
  String wifiNetworkTypeLoc = 'Unknown';

  Future<void> getBatteryLevel() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;

    chargingStatus = '$batteryLevel';
    notifyListeners();
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
    notifyListeners();
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
    await getSystemName();
    await getBrowserName();
    await getBatteryLevel();
    await getWifiNetworkType();
    await getUserLocation();
    await getPermission();
    getToken();
    roleAppUsersPost();
  }

  // Chat mini game
  TextEditingController chatInputController = TextEditingController();

  String apiKey = 'AIzaSyCcyArg2tLT6FgAIvfe_mU2Q1DAzGC1gD4';
  String searchEngineId = '23ca64046b86840ed';
  String yutubeApiKey = 'AIzaSyDNtdImGrUc9SUOCw3Fm8bnbRoa48jfoXg';

  String userText = "Type Something";
  String replyTest = "See The Result";
  bool showTable = false;
  bool container = false;
  bool circle = false;
  int rNumber = 0;
  List<Messages> listMesseges = [];

  final ScrollController chatScrollController = ScrollController();

  void addItemToList(Messages message) {
      listMesseges.add(message);

    // Delay the scroll animation slightly
    Future.delayed(const Duration(milliseconds: 100), () {
      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    notifyListeners();
  }
  BuildContext? ctx ;
  chatGetReply() async {
    final String userGivenText = chatInputController.text.trim();
    if (userGivenText.isNotEmpty) {
      userText = userGivenText;
      chatInputController.clear();
      String inputText = userGivenText.toLowerCase();
      List<String> listImages = [];
      String songName = '';
      showTable = false;
      container = false;
      circle = false;
      addItemToList(Messages(
          msg: userText,
          left: false,
          song: songName,
          shape: 'null',
          images: []));

      String? rText;
      if (userGivenText.isNumeric) {
        rNumber = int.parse(userGivenText);
        rText = rNumber.toString();
        showTable = true;
      } else {
        List<String> name = userGivenText.split(' ');
        if (name[0] == 'create') {
          if (name.contains('container')) {
            container = true;
            rText = 'Container';
          } else if (name.contains('circle')) {
            circle = true;
            rText = 'Circle';
          } else {
            rText = "I didn't get";
          }
        } else if (name[0] == 'open') {
          if (name.contains('admin')) {
            rText = 'Sorry...';
            Navigator.of(ctx!).push(AdminPageRoot());
          } else if (name.contains('resume')) {
            rText = 'Opening...';
            Navigator.of(ctx!)
                .push(MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            rText = "I didn't get";
          }
        } else if (name[0] == 'play') {
          rText = 'Here we go...';
          songName = await playVideo(userText) ?? '';
        } else if (name.contains('show') &&
            name.contains('images') &&
            name.contains('of')) {
          // Extract the keyword after 'of'
          int index = name.indexOf('of');
          if (index < name.length - 1) {
            String keyword = name[index + 1];
            rText = 'Here we go...';
            listImages = await fetchGoogleImages(keyword);
          } else {
            rText = "I didn't get";
          }
        }

        List<String> checkKeys = CommonUse().getReplayList.keys.toList();

        await Future.forEach(checkKeys, (key) async {
          if (key.toLowerCase() == inputText) {
            rText = CommonUse().getReplayList[key].toString();
          }
        });
        if (rText.toString() == 'null' || rText == "I didn't get") {
          rText = await generateGoogleResponse(userText);
        }
      }

      String shape = container ? 'container' : (circle ? 'circle' : 'null');
      addItemToList(Messages(
          msg: rText ?? "I didn't get",
          left: true,
          song: songName,
          shape: shape,
          images: listImages));

        replyTest = rText ?? "I didn't get";
      notifyListeners();
    }
  }

  List<String> filteredSuggestions = [];
  int selectedIndex = -1;

  void filterSuggestions() {
      String searchText = chatInputController.text.toLowerCase();
      filteredSuggestions = Constants.suggestions
          .where((suggestion) => suggestion.toLowerCase().contains(searchText))
          .toList();
      notifyListeners();
  }
  chatInit(){
    selectedIndex = filteredSuggestions.length-1;
    chatInputController.addListener(filterSuggestions);
  }
  // API endpoint for playing a video
  Future<String?> playVideo(String videoName) async {
    try {
      // Search for the video on YouTube
      String searchQuery = Uri.encodeQueryComponent(videoName);
      final Uri searchUri = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchQuery&type=video&key=$yutubeApiKey');
      final searchResponse = await http.get(searchUri);

      if (searchResponse.statusCode == 200) {
        Map<String, dynamic> searchData = json.decode(searchResponse.body);
        if (searchData.containsKey('items')) {
          List<dynamic> items = searchData['items'];
          if (items.isNotEmpty) {
            String videoId = items[0]['id']['videoId'];
            print(videoId);
            String videoUrl = 'https://www.youtube.com/watch?v=$videoId';
            // You can implement your video playback logic here using the videoUrl
            return videoId;
          }
        }
      }
    } catch (e) {
      print('Error playing video: $e');
    }

    return null;
  }

  Future<List<String>> fetchGoogleImages(String keyword) async {
    final Uri uri = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&q=$keyword&searchType=image',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('items')) {
        List<dynamic> items = data['items'];
        if (items.isNotEmpty) {
          return items.map((item) => item['link']).cast<String>().toList();
          // return 'Showing images of $keyword';
        }
      }
    }
    return [];
  }

  Future<String?> generateGoogleResponse(String query) async {
    final Uri uri = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&q=$query',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('items')) {
        List<dynamic> items = data['items'];
        if (items.isNotEmpty) {
          return items[0]['snippet'];
        }
      }
    }

    return null;
  }

}
