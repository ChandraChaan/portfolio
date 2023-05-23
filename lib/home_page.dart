// import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
import 'package:visibility_detector/visibility_detector.dart';
import 'animation_route/navigate_newpage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  ScrollController? _scrollController;
  double? _scrollPosition;
  double? _maxscroll;
  double? _maxscrollpercentage;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      _maxscroll = _scrollController?.position.maxScrollExtent;
      // _scrollController?.toString();
      _maxscrollpercentage =
          double.parse((_scrollPosition! / _maxscroll! * 1).toStringAsFixed(1));
      // print(_maxscrollpercentage?.toStringAsFixed(1)! + 'ha');
    });
  }

  @override
  void initState() {
    super.initState();
    //get token
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen(setToken);
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
  }

  final aboutScrollKey = GlobalKey();
  bool _isAboutVisible = false;
  final expScrollKey = GlobalKey();
  bool _isExpVisible = false;

  final portfoScrollKey = GlobalKey();
  bool _isPortfoVisible = false;

  final skillScrollKey = GlobalKey();
  bool _isSkillsVisible = false;

  final projectsScrollKey = GlobalKey();
  bool _isProjectsVisible = false;

  final contactScrollKey = GlobalKey();
  bool _isContactVisible = false;

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

  @override
  Widget build(BuildContext context) {
    return ResponsiveHome(
      mobile: mobileUI(context),
      tablet: tabletUI(context),
      desktop: deskTopUI(context),
    );
  }

  Widget scrolIndicator() {
    return _maxscrollpercentage != null && _maxscrollpercentage != 0.00
        ? GestureDetector(
            onDoubleTap: () {
              Navigator.of(context).push(SecondPageRoute());
            },
            child: SizedBox(
              height: 20,
              child: LinearProgressIndicator(
                backgroundColor: Colors.cyan[100],
                color: Theme.of(context).indicatorColor,
                value: _maxscrollpercentage,
                // valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget themeCOlorChange() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SettingsPopup();
            },
          );
        },
        child: Icon(
          Icons.settings,
          color: Theme.of(context).primaryColor,
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
                          // const SizedBox(
                          //   height: 10,
                          // ),
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
                            child: CommonText(
                                text: 'ABOUT',
                                color: _isAboutVisible
                                    ? getOppositeColor(
                                        Theme.of(context).indicatorColor)
                                    : null),
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
                                color: _isExpVisible
                                    ? getOppositeColor(
                                        Theme.of(context).indicatorColor)
                                    : null),
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
                                color: _isPortfoVisible
                                    ? getOppositeColor(
                                        Theme.of(context).indicatorColor)
                                    : null),
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
                                color: _isSkillsVisible
                                    ? getOppositeColor(
                                        Theme.of(context).indicatorColor)
                                    : null),
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
                                  color: _isProjectsVisible
                                      ? getOppositeColor(
                                          Theme.of(context).indicatorColor)
                                      : null)),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                srollSmooth(contactScrollKey.currentContext!);
                              },
                              child: CommonText(
                                color: _isContactVisible
                                    ? getOppositeColor(
                                        Theme.of(context).indicatorColor)
                                    : null,
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
                      controller: _scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          VisibilityDetector(
                            key: aboutScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = true;
                                  _isExpVisible = false;
                                  _isPortfoVisible = false;
                                  _isSkillsVisible = false;
                                  _isProjectsVisible = false;
                                  _isContactVisible = false;
                                });
                              }
                            },
                            child: const About(),
                          ),
                          VisibilityDetector(
                            key: expScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = false;
                                  _isExpVisible = true;
                                  _isPortfoVisible = false;
                                  _isSkillsVisible = false;
                                  _isProjectsVisible = false;
                                  _isContactVisible = false;
                                });
                              }
                            },
                            child: const Experience(
                              smallCard: false,
                            ),
                          ),
                          VisibilityDetector(
                            key: portfoScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = false;
                                  _isExpVisible = false;
                                  _isPortfoVisible = true;
                                  _isSkillsVisible = false;
                                  _isProjectsVisible = false;
                                  _isContactVisible = false;
                                });
                              }
                            },
                            child: const Portfolio(
                              smallCard: false,
                            ),
                          ),
                          VisibilityDetector(
                            key: skillScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = false;
                                  _isExpVisible = false;
                                  _isPortfoVisible = false;
                                  _isSkillsVisible = true;
                                  _isProjectsVisible = false;
                                  _isContactVisible = false;
                                });
                              }
                            },
                            child: const Skills(),
                          ),
                          VisibilityDetector(
                            key: projectsScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = false;
                                  _isExpVisible = false;
                                  _isPortfoVisible = false;
                                  _isSkillsVisible = false;
                                  _isProjectsVisible = true;
                                  _isContactVisible = false;
                                });
                              }
                            },
                            child: const Projects(
                              smallCard: false,
                            ),
                          ),
                          VisibilityDetector(
                            key: contactScrollKey,
                            onVisibilityChanged: (visibilityInfo) {
                              if (visibilityInfo.visibleFraction == 1) {
                                setState(() {
                                  _isAboutVisible = false;
                                  _isExpVisible = false;
                                  _isPortfoVisible = false;
                                  _isSkillsVisible = false;
                                  _isProjectsVisible = false;
                                  _isContactVisible = true;
                                });
                              }
                            },
                            child: const Contact(
                              isWeb: true,
                            ),
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
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VisibilityDetector(
                      key: aboutScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = true;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const About(
                        mobileImg: true,
                        tabImg: true,
                      ),
                    ),
                    VisibilityDetector(
                      key: expScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = true;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Experience(
                        smallCard: false,
                      ),
                    ),
                    VisibilityDetector(
                      key: portfoScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = true;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Portfolio(
                        smallCard: false,
                      ),
                    ),
                    VisibilityDetector(
                      key: skillScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = true;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Skills(),
                    ),
                    VisibilityDetector(
                      key: projectsScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = true;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Projects(
                        smallCard: false,
                      ),
                    ),
                    VisibilityDetector(
                      key: contactScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = true;
                          });
                        }
                      },
                      child: const Contact(
                        isWeb: true,
                      ),
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
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VisibilityDetector(
                      key: aboutScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = true;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const About(
                        mobileImg: true,
                      ),
                    ),
                    VisibilityDetector(
                      key: expScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = true;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Experience(
                        smallCard: true,
                      ),
                    ),
                    VisibilityDetector(
                      key: portfoScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = true;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Portfolio(
                        smallCard: true,
                      ),
                    ),
                    VisibilityDetector(
                      key: skillScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = true;
                            _isProjectsVisible = false;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Skills(),
                    ),
                    VisibilityDetector(
                      key: projectsScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = true;
                            _isContactVisible = false;
                          });
                        }
                      },
                      child: const Projects(
                        smallCard: true,
                      ),
                    ),
                    VisibilityDetector(
                      key: contactScrollKey,
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction == 1) {
                          setState(() {
                            _isAboutVisible = false;
                            _isExpVisible = false;
                            _isPortfoVisible = false;
                            _isSkillsVisible = false;
                            _isProjectsVisible = false;
                            _isContactVisible = true;
                          });
                        }
                      },
                      child: const Contact(
                        isWeb: false,
                      ),
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
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: _token.toString()));
                    srollSmooth(aboutScrollKey.currentContext!);
                  },
                  child: CommonText(
                      text: 'ABOUT',
                      color: _isAboutVisible
                          ? getOppositeColor(Theme.of(context).indicatorColor)
                          : null),
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
                      color: _isExpVisible
                          ? getOppositeColor(Theme.of(context).indicatorColor)
                          : null),
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
                      color: _isPortfoVisible
                          ? getOppositeColor(Theme.of(context).indicatorColor)
                          : null),
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
                      color: _isSkillsVisible
                          ? getOppositeColor(Theme.of(context).indicatorColor)
                          : null),
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
                        color: _isProjectsVisible
                            ? getOppositeColor(Theme.of(context).indicatorColor)
                            : null)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(contactScrollKey.currentContext!);
                    },
                    child: CommonText(
                      color: _isContactVisible
                          ? getOppositeColor(Theme.of(context).indicatorColor)
                          : null,
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
    if (Provider.of<UserInfo>(context, listen: false).musicMode) {
      AudioPlayer().play(AssetSource('audio/decide.mp3'));
    }
    Scrollable.ensureVisible(context,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}

class SettingsPopup extends StatefulWidget {
  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  // Left Side - Sections
                  SizedBox(
                    width: 200.0, // Adjust the width as needed
                    child: ListView(
                      children: [
                        SectionItem(
                          title: 'Theme',
                          icon: Icons.color_lens,
                          index: 0,
                          selectedIndex: _selectedIndex,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                        ),
                        SectionItem(
                          title: 'Data Control',
                          icon: Icons.data_usage,
                          index: 1,
                          selectedIndex: _selectedIndex,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                        ),
                        SectionItem(
                          title: 'General Settings',
                          icon: Icons.settings,
                          index: 2,
                          selectedIndex: _selectedIndex,
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Right Side - Content
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        ThemeSection(),
                        DataControlSection(),
                        GeneralSettingsSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  SectionItem({
    required this.title,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    final textColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).indicatorColor;

    return ListTile(
      leading: Icon(
        icon,
        color: textColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: onTap,
      tileColor: isSelected ? backgroundColor.withOpacity(0.2) : null,
    );
  }
}

class ThemeSection extends StatelessWidget {
  List<Color> currentColors = [
    Colors.pink,
    Colors.purple,
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
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.red,
    Colors.deepOrangeAccent,
    Colors.amberAccent,
    Colors.yellowAccent,
    Colors.limeAccent,
    Colors.greenAccent,
    Colors.tealAccent,
    Colors.cyanAccent,
    Colors.lightBlueAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.brown,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Select theme color',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (int a = 0; a < currentColors.length; a++)
                ColorItem(color: currentColors[a]),
            ],
          ),
        ],
      ),
    );
  }
}

class DataControlSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Control',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Data control settings',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Setting 1',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          'Setting 2',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // Add more data control settings here
      ],
    );
  }
}

class GeneralSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General Settings',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'General settings',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Setting 1',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          'Setting 2',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // Add more general settings here
      ],
    );
  }
}

class ColorItem extends StatelessWidget {
  final Color color;

  ColorItem({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Provider.of<UserInfo>(context, listen: false)
                .themeColorChange(color);
          },
          borderRadius: BorderRadius.circular(25.0),
          splashColor: Colors.white.withOpacity(0.5),
          customBorder: const CircleBorder(),
          child:
              Provider.of<UserInfo>(context, listen: false).themeColor == color
                  ? const Icon(Icons.check)
                  : null,
        ),
      ),
    );
  }
}
