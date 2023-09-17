// import 'dart:html' as html;

import 'package:client_information/client_information.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:portfoli_web/providers/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animation_route/navigate_newpage.dart';
import '../chat_game/message_domain.dart';
import '../core/home_page.dart';
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

  final Connectivity _connectivity = Connectivity();

  String deviceTypeName = 'Unknown';
  int screenWidth =0;
  int screenHeight =0;
  double deviceMemory=0;
  String systemName='';
  String browserName='';
  String batteryStatus = 'Unknown';
  String wifiNetworkStatus = 'Unknown';
  String seenChatPage = '0';
  String seenAdminPage = '0';
  String seenResumePage = '0';
  String address = '';
  double latitude = 0.0;
  double longitude = 0.0;

  // home page properties,
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 2.0);
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
    updateUserDeviceInfo();
    saveData();
    notifyListeners();
  }

  changeMusicMode() {
    musicMode = !musicMode;
    updateUserDeviceInfo();
    saveData();
    notifyListeners();
  }

  themeColorChange(Color cl) {
    int colorCode = cl.value;
    String colorHex =
        '0x${colorCode.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    themeColor = cl;
    themeStringColor = colorHex;
    oppositeColor = getOppositeColor(cl);
    saveData();
    updateUserDeviceInfo();
    notifyListeners();
  }

  // Storing data
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('deviceTypeName', deviceTypeName);
    prefs.setString('browserName', browserName);
    prefs.setString('systemName', systemName);
    prefs.setString('address', address.toString());
    prefs.setDouble('deviceMemory', deviceMemory);
    prefs.setDouble('latitude', latitude);
    prefs.setDouble('latitude', latitude);
    prefs.setInt('screenWidth', screenWidth);
    prefs.setInt('screenHeight', screenHeight);
    prefs.setString('batteryStatus', batteryStatus);
    prefs.setString('wifiNetworkStatus', wifiNetworkStatus);
    prefs.setBool('themeLightMode', themeLightMode);
    prefs.setBool('musicMode', musicMode);
    prefs.setInt('themeColor', themeColor.value);
    prefs.setInt('oppositeColor', oppositeColor.value);
    prefs.setString('themeStringColor', themeStringColor);
    prefs.setString('seenChatPage', seenChatPage);
    prefs.setString('seenResumePage', seenResumePage);
    prefs.setString('seenAdminPage', seenAdminPage);
    prefs.setString('deviceId', deviceId);
  }

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

  Future<void> getUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;

    final addressloc = await getAddress(latitude, longitude);

    address = addressloc;
    prefs.setString('address', address);
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

  Future<void> updateDeviceInfo() async {
    await _updateScreenInfo();
    await _updateBatteryStatus();
    await _updateWifiNetworkStatus();
    _updateDeviceType();
    // _updateBrowserName();
    saveData();
    notifyListeners();
  }

  Future<void> _updateScreenInfo() async {
    ClientInformation info = await ClientInformation.fetch();
    systemName = info.osName ?? '';
  }

  Future<void> _updateBatteryStatus() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    batteryStatus = '$batteryLevel';
  }

  Future<void> _updateWifiNetworkStatus() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      wifiNetworkStatus = 'Connected';
    } else {
      wifiNetworkStatus = 'Not connected';
    }
  }

  void _updateDeviceType() {
    if (screenWidth != 0) {
      if (screenWidth< 600) {
        deviceTypeName = 'Mobile';
      } else if (screenWidth < 1200) {
        deviceTypeName = 'Tablet';
      } else {
        deviceTypeName = 'Desktop';
      }
    } else {
      deviceTypeName = 'Unknown';
    }
  }

  // void _updateBrowserName() {
  //   String userAgent = html.window.navigator.userAgent;
  //   if (userAgent.contains('Chrome')) {
  //     browserName = 'Chrome';
  //   } else if (userAgent.contains('Firefox')) {
  //     browserName = 'Firefox';
  //   } else if (userAgent.contains('Safari')) {
  //     browserName = 'Safari';
  //   } else if (userAgent.contains('Opera') || userAgent.contains('OPR')) {
  //     browserName = 'Opera';
  //   } else if (userAgent.contains('Edge')) {
  //     browserName = 'Edge';
  //   } else if (userAgent.contains('MSIE') || userAgent.contains('Trident/')) {
  //     browserName = 'Internet Explorer';
  //   } else {
  //     browserName = userAgent;
  //   }
  // }

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

  Future<void> updateUserDeviceInfo() async {
    print('Starting updateUserDeviceInfo function.');

    final UserRecordRepository repository = UserRecordRepository();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserRecord? userRecord;
    if (deviceId.isNotEmpty) {
      print('Fetching user record from Firestore...');
      userRecord = await repository.getRecord(deviceId);
    } else {
      print('No token found in localStorage. Creating a new user record.');
    }

    if (userRecord != null) {
      print('Updating existing user record in Firestore...');
      userRecord.deviceTypeName = deviceTypeName;
      userRecord.systemName = systemName;
      userRecord.browserName = browserName;
      userRecord.address = address.toString();
      userRecord.deviceMemory = deviceMemory;
      userRecord.latitude = latitude;
      userRecord.longitude = longitude;
      userRecord.screenWidth = screenWidth;
      userRecord.screenHeight = screenHeight;
      userRecord.batteryStatus = batteryStatus;
      userRecord.wifiNetworkStatus = wifiNetworkStatus;
      userRecord.musicMode = musicMode;
      userRecord.themeLightMode = themeLightMode;
      userRecord.themeStringColor = themeStringColor;
      userRecord.seenChatScreen = seenChatPage;
      userRecord.seenFullResume = seenResumePage;
      userRecord.seenAdminScreen = seenAdminPage;
      userRecord.date = DateTime.now().toString();

      await repository.updateRecord(userRecord);
    } else {
      print('Creating new user record in Firestore...');
      final newRecord = UserRecord(
        id: deviceId.isEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : deviceId,
        deviceTypeName: deviceTypeName,
        systemName: systemName,
        browserName: browserName,
        address: address.toString(),
        deviceMemory: deviceMemory,
        latitude: latitude,
        longitude: longitude,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        batteryStatus: batteryStatus,
        wifiNetworkStatus: wifiNetworkStatus,
        musicMode: musicMode,
        themeLightMode: themeLightMode,
        themeStringColor: themeStringColor,
        seenChatScreen: seenChatPage,
        seenFullResume: seenResumePage,
        seenAdminScreen: seenAdminPage,
        date: DateTime.now().toString(),
      );
      final newDeviceId = await repository.addNewRecord(newRecord);
      deviceId = newDeviceId;
      prefs.setString('deviceId', deviceId);
    }
    notifyListeners();
  }

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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString('deviceId') ?? deviceId;
    await updateDeviceInfo();
    await getPermission();
    await getUserLocation();
    getToken();
    if (deviceId.isEmpty) {
      updateUserDeviceInfo();
    }
    else {
      // Retrieving the int value of the Material color
      int? color1 = prefs.getInt('themeColor');
      int? color2 = prefs.getInt('oppositeColor');

      musicMode = prefs.getBool('musicMode') ?? musicMode;
      themeColor = color1 != null ? Color(color1) : themeColor;
      oppositeColor = color2 != null ? Color(color2) : oppositeColor;
      seenAdminPage = prefs.getString('seenAdminPage') ?? seenAdminPage;
      seenResumePage = prefs.getString('seenResumePage') ?? seenResumePage;
      seenChatPage = prefs.getString('seenChatPage') ?? seenChatPage;
      themeStringColor = prefs.getString('themeStringColor') ?? themeStringColor;
      themeLightMode = prefs.getBool('themeLightMode') ?? themeLightMode;
      deviceTypeName = prefs.getString('deviceTypeName') ?? deviceTypeName;
      browserName = prefs.getString('browserName') ?? browserName;
      systemName = prefs.getString('systemName') ?? systemName;
      address = prefs.getString('address') ?? address;
      deviceMemory = prefs.getDouble('deviceMemory') ?? deviceMemory;
      latitude = prefs.getDouble('latitude') ?? latitude;
      latitude = prefs.getDouble('latitude') ?? latitude;
      screenWidth = prefs.getInt('screenWidth') ?? screenWidth;
      screenHeight = prefs.getInt('screenHeight') ?? screenHeight;
      batteryStatus = prefs.getString('batteryStatus') ?? batteryStatus;
      wifiNetworkStatus = prefs.getString('wifiNetworkStatus') ?? wifiNetworkStatus;
    }
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

  BuildContext? ctx;

  chatGetReply() async {
    final String userGivenText = chatInputController.text.trim();
    if (userGivenText.isNotEmpty) {
      userText = userGivenText;
      chatInputController.clear();
      seenChatPage = '1';
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
      }
      else {
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
        }
        else if (name[0] == 'open') {
          if (name.contains('admin')) {
            rText = 'Opened...';
            seenAdminPage = '1';
            saveData();
            updateUserDeviceInfo();
            Navigator.of(ctx!).push(AdminPageRoot());
          } else if (name.contains('login')) {
            rText = 'Opened...';

            Navigator.of(ctx!).push(AuthScreenRoute());
          } else if (name.contains('resume')) {
            rText = 'Opening...';
            seenResumePage = '1';
            saveData();
            updateUserDeviceInfo();
            Navigator.of(ctx!).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            rText = "I didn't get";
          }
        }
        else if (name[0] == 'play') {
          rText = 'Here we go...';
          songName = await playVideo(userText) ?? '';
        }
        else if (name.contains('show') &&
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

  chatInit() {
    selectedIndex = filteredSuggestions.length - 1;
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
