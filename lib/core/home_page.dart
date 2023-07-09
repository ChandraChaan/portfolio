import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:portfoli_web/utils/settings_popup.dart';
import 'package:provider/provider.dart';
import '../../projects/projects.dart';
import '../../contact/contact.dart';
import '../../experience/experience.dart';
import '../../portfolio/portfolio.dart';
import '../../skills/skills.dart';
import '../about/about.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../animation_route/navigate_newpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;
  int notificationCount = 0;

  showDeniedPopUp() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Disabled'),
          content: const Text('Notification permission has been disabled'),
          actions: [
            TextButton(
              child: const Text('Ask Again'),
              onPressed: () async {
                await Provider.of<UserInfo>(context, listen: false)
                    .getPermission();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
                // Perform any additional logic or call your provider method to close the application.
              },
            ),
          ],
        );
      },
    );
  }

  sendNotificationThis() {
    if (Provider.of<UserInfo>(context, listen: false).grantedPermission != 1) {
      showDeniedPopUp();
    } else {
      Provider.of<UserInfo>(context, listen: false).sendNotification();
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: mobileUI(context),
      tablet: tabletUI(context),
      desktop: deskTopUI(context),
    );
  }

  Widget scrolIndicator() {
    return _maxscrollpercentage != null && _maxscrollpercentage != 0.00
        ? GestureDetector(
            onDoubleTap: () {
              Navigator.of(context).push(ChatGameRoute());
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
              return const SettingsPopup();
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
                                  ? (Theme.of(context).focusColor)
                                  : null,
                              style: _isAboutVisible
                                  ? FontStyles.heading6
                                  : FontStyles.button,
                            ),
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
                                  ? (Theme.of(context).focusColor)
                                  : null,
                              style: _isExpVisible
                                  ? FontStyles.heading6
                                  : FontStyles.button,
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
                                style: _isPortfoVisible
                                    ? FontStyles.heading6
                                    : FontStyles.button,
                                color: _isPortfoVisible
                                    ? (Theme.of(context).focusColor)
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
                                style: _isSkillsVisible
                                    ? FontStyles.heading6
                                    : FontStyles.button,
                                color: _isSkillsVisible
                                    ? (Theme.of(context).focusColor)
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
                                  style: _isProjectsVisible
                                      ? FontStyles.heading6
                                      : FontStyles.button,
                                  color: _isProjectsVisible
                                      ? (Theme.of(context).focusColor)
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
                                    ? (Theme.of(context).focusColor)
                                    : null,
                                style: _isContactVisible
                                    ? FontStyles.heading6
                                    : FontStyles.button,
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
                            child: Portfolio(
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
                      child: Portfolio(
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
                themeCOlorChange(),
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
                          ? (Theme.of(context).focusColor)
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
                          ? (Theme.of(context).focusColor)
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
                          ? (Theme.of(context).focusColor)
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
                          ? (Theme.of(context).focusColor)
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
                            ? (Theme.of(context).focusColor)
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
                          ? (Theme.of(context).focusColor)
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
