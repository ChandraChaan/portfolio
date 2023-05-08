// import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:provider/provider.dart';
import '../projects/projects.dart';
import '../contact/contact.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../skills/skills.dart';
import 'about/about.dart';
import 'package:http/http.dart' as http;

import 'animation_route/navigate_newpage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color currentColor = Colors.blue;
  List<Color> currentColors = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

   changeColor(Color color){
     Provider.of<UserInfo>(context).themeColorChange(color);
}

  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  String? _token;
  Stream<String>? _tokenStream;
  int notificationCount = 0;

  void setToken(String? token) {
    print('FCM TokenToken: $token');
    setState(() {
      _token = token;
    });
  }

  //send notification
  sendPushMessageToWeb() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
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
              'to': _token,
              'message': {
                'token': _token,
              },
              "notification": {"title": "Dumpala", "body": "Chandra ObulReddy"}
            }),
          )
          .then((value) => print(value.body));
      print('FCM request for web sent!');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //get token
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen(setToken);
  }

  final scrollControllerLocal = ScrollController();

  final aboutScrollKey = GlobalKey();

  final expScrollKey = GlobalKey();

  final portfoScrollKey = GlobalKey();

  final skillScrollKey = GlobalKey();

  final projectsScrollKey = GlobalKey();

  final contactScrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ResponsiveHome(
      mobile: mobileUI(context),
      tablet: tabletUI(context),
      desktop: deskTopUI(context),
    );
  }

  Widget scrolIndicator() {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).push(SecondPageRoute());
      },
      child: SizedBox(
        height: 20,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyan[100],
          value: 0.7,
          // valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }

  Widget themeCOlorChange(){
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose Color'),
            // content: const Text('AlertDialog description'),
            content: Container(
              // height: 100,
              child: Expanded(
                child: BlockPicker(
                    availableColors: currentColors,
                    pickerColor: currentColor,
                    onColorChanged: changeColor),
              ),
            ),

            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, 'Cancel'),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
        child: Icon(
          Icons.settings,
          color: Theme.of(context).primaryColor,
          size: 30.0,
        ),
      ),
    );
  }

  Widget deskTopUI(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            scrolIndicator(),
            Expanded(
              child: Row(
                children: [
                  // side menu
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Provider.of<UserInfo>(context).themeColor,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          themeCOlorChange(),
                          SizedBox(
                            height: 110,
                            child: Consumer<UserInfo>(
                              builder: (context, provider, child) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        provider.themeLightMode
                                            ? const Icon(
                                                Icons.sunny,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.nightlight,
                                                color: Colors.black,
                                              ),
                                        Transform.scale(
                                            scale: 1,
                                            child: Switch(
                                              onChanged: (bool newVal) {
                                                provider.changeThemeMode();
                                              },
                                              value: provider.themeLightMode,
                                              activeColor: Colors.white,
                                              activeTrackColor: Colors.white38,
                                              inactiveThumbColor: Colors.black,
                                              inactiveTrackColor:
                                                  Colors.black38,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        provider.musicMode
                                            ? const Icon(
                                                Icons.add_alert_sharp,
                                                color: Colors.lightGreenAccent,
                                              )
                                            : const Icon(
                                                Icons.volume_mute_outlined,
                                                color: Colors.redAccent,
                                              ),
                                        Transform.scale(
                                            scale: 1,
                                            child: Switch(
                                              onChanged: (bool newVal) {
                                                provider.changeMusicMode();
                                              },
                                              value: provider.musicMode,
                                              activeColor: Colors.green,
                                              activeTrackColor:
                                                  Colors.greenAccent,
                                              inactiveThumbColor:
                                                  Colors.redAccent,
                                              inactiveTrackColor: Colors.red,
                                            )),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          sendPushMessageToWeb();
                                        },
                                        child: Text('Notification', style: styl)
                                            .animate(effects: [
                                          const ShakeEffect(
                                              duration: Duration(minutes: 2),
                                              delay: Duration(seconds: 5))
                                        ])),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 160,
                            width: 140,
                            decoration: const BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Container(
                                  height: 150,
                                  width: 130,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      image: DecorationImage(
                                        image: AssetImage("assets/profile.jpg"),
                                        fit: BoxFit.fill,
                                      ))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: _token.toString()));
                              srollSmooth(aboutScrollKey.currentContext!);
                            },
                            child: CommonText(text: 'ABOUT'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              srollSmooth(expScrollKey.currentContext!);
                            },
                            child: CommonText(
                              text: "EXPERIENCE",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              srollSmooth(portfoScrollKey.currentContext!);
                            },
                            child: CommonText(
                              text: "PORTFOLIO",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              srollSmooth(skillScrollKey.currentContext!);
                            },
                            child: CommonText(
                              text: "SKILLS",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                srollSmooth(projectsScrollKey.currentContext!);
                              },
                              child: CommonText(
                                text: "PROJECTS",
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                srollSmooth(contactScrollKey.currentContext!);
                              },
                              child: CommonText(
                                text: "CONTACT",
                              )),
                        ],
                      ),
                    ),
                  ),
                  // body
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          About(
                            key: aboutScrollKey,
                          ),
                          Experience(
                            smallCard: false,
                            key: expScrollKey,
                          ),
                          Portfolio(
                            smallCard: false,
                            key: portfoScrollKey,
                          ),
                          Skills(
                            key: skillScrollKey,
                          ),
                          Projects(
                            smallCard: false,
                            key: projectsScrollKey,
                          ),
                          Contact(
                            isWeb: true,
                            key: contactScrollKey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget tabletUI(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Scaffold(
      body: Column(
        children: [
          scrolIndicator(),
          Expanded(
            child: Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              ),
              drawer: drawerMobile(context),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    About(
                      mobileImg: true,
                      tabImg: true,
                      key: aboutScrollKey,
                    ),
                    Experience(
                      smallCard: false,
                      key: expScrollKey,
                    ),
                    Portfolio(
                      smallCard: false,
                      key: portfoScrollKey,
                    ),
                    Skills(
                      key: skillScrollKey,
                    ),
                    Projects(
                      smallCard: false,
                      key: projectsScrollKey,
                    ),
                    Contact(
                      isWeb: true,
                      key: contactScrollKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileUI(BuildContext context) {
    // TextStyle? styl = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      body: Column(
        children: [
          scrolIndicator(),
          Expanded(
            child: Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              ),
              drawer: drawerMobile(context),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    About(
                      key: aboutScrollKey,
                      mobileImg: true,
                    ),
                    Experience(
                      smallCard: true,
                      key: expScrollKey,
                    ),
                    Portfolio(
                      smallCard: true,
                      key: portfoScrollKey,
                    ),
                    Skills(
                      key: skillScrollKey,
                    ),
                    Projects(
                      smallCard: true,
                      key: projectsScrollKey,
                    ),
                    Contact(
                      isWeb: false,
                      key: contactScrollKey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawerMobile(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: Provider.of<UserInfo>(context).themeColor,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Consumer<UserInfo>(
                    builder: (context, provider, child) {
                      return Column(
                        children: [
                          themeCOlorChange(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.themeLightMode
                                  ? const Icon(
                                      Icons.sunny,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.nightlight,
                                      color: Colors.black,
                                    ),
                              Transform.scale(
                                  scale: 1,
                                  child: Switch(
                                    onChanged: (bool newVal) {
                                      provider.changeThemeMode();
                                    },
                                    value: provider.themeLightMode,
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.white38,
                                    inactiveThumbColor: Colors.black,
                                    inactiveTrackColor: Colors.black38,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.musicMode
                                  ? const Icon(
                                      Icons.add_alert_sharp,
                                      color: Colors.lightGreenAccent,
                                    )
                                  : const Icon(
                                      Icons.volume_mute_outlined,
                                      color: Colors.redAccent,
                                    ),
                              Transform.scale(
                                  scale: 1,
                                  child: Switch(
                                    onChanged: (bool newVal) {
                                      provider.changeMusicMode();
                                    },
                                    value: provider.musicMode,
                                    activeColor: Colors.green,
                                    activeTrackColor: Colors.greenAccent,
                                    inactiveThumbColor: Colors.redAccent,
                                    inactiveTrackColor: Colors.red,
                                  )),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                sendPushMessageToWeb();
                              },
                              child: Text(
                                'Notification',
                                style: styl,
                              ).animate(effects: [
                                const ShakeEffect(
                                    duration: Duration(minutes: 2),
                                    delay: Duration(seconds: 5))
                              ])),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 160,
                  width: 140,
                  decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Center(
                    child: Container(
                        height: 150,
                        width: 130,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/profile.jpg"),
                              fit: BoxFit.fill,
                            ))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(aboutScrollKey.currentContext!);
                  },
                  child: CommonText(text: 'ABOUT'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(expScrollKey.currentContext!);
                  },
                  child: CommonText(
                    text: "EXPERIENCE",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(portfoScrollKey.currentContext!);
                  },
                  child: CommonText(
                    text: "PORTFOLIO",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(skillScrollKey.currentContext!);
                  },
                  child: CommonText(
                    text: "SKILLS",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(projectsScrollKey.currentContext!);
                    },
                    child: CommonText(
                      text: "PROJECTS",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(contactScrollKey.currentContext!);
                    },
                    child: CommonText(
                      text: "CONTACT",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  srollSmooth(BuildContext context) {
    // if(Provider.of<UserInfo>(context, listen: false).musicMode) {
    //   AudioPlayer().play(AssetSource('audio/decide.mp3'));
    // }
    Scrollable.ensureVisible(context,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}


