import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../projects/projects.dart';
import '../contact/contact.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../skills/skills.dart';
import '../utils/font_style.dart';

import 'about/about.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final scrollControllerLocal = ScrollController();

  final aboutScrollKey = GlobalKey();

  final expScrollKey = GlobalKey();

  final portfoScrollKey = GlobalKey();

  final skillScrollKey = GlobalKey();

  final projectsScrollKey = GlobalKey();

  final contactScrollKey = GlobalKey();


  @override
  void initState() {
    // scrollControllerLocal.addListener(() {
    //
    // });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ResponsiveHome(
      mobile: mobileUI(),
      tablet: tabletUI(),
      desktop: deskTopUI(),
    );
  }

  Widget deskTopUI() {
    return Scaffold(
        body: Row(
      children: [
        // side menu
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  child:
                      getTextStyle("ABOUT", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(expScrollKey.currentContext!);
                  },
                  child: getTextStyle(
                      "EXPERIENCE", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(portfoScrollKey.currentContext!);
                  },
                  child: getTextStyle(
                      "PORTFOLIO", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(skillScrollKey.currentContext!);
                  },
                  child:
                      getTextStyle("SKILLS", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(
                          projectsScrollKey.currentContext!);
                    },
                    child: getTextStyle(
                        "PROJECTS", FontWeight.w500, Colors.white, 20)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(
                          contactScrollKey.currentContext!);
                    },
                    child: getTextStyle(
                        "CONTACT", FontWeight.w500, Colors.white, 20)),
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
    ));
  }

  Widget tabletUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawerMobile(),
      body: SingleChildScrollView(
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
    );
  }

  Widget mobileUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawerMobile(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            About(
              key: aboutScrollKey,
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
    );
  }

  Drawer drawerMobile() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: Colors.blue,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  child:
                      getTextStyle("ABOUT", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(expScrollKey.currentContext!);
                  },
                  child: getTextStyle(
                      "EXPERIENCE", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(portfoScrollKey.currentContext!);
                  },
                  child: getTextStyle(
                      "PORTFOLIO", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(skillScrollKey.currentContext!);
                  },
                  child:
                      getTextStyle("SKILLS", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(
                          projectsScrollKey.currentContext!);
                    },
                    child: getTextStyle(
                        "PROJECTS", FontWeight.w500, Colors.white, 20)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(
                          contactScrollKey.currentContext!);
                    },
                    child: getTextStyle(
                        "CONTACT", FontWeight.w500, Colors.white, 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  srollSmooth(BuildContext context) {
    Scrollable.ensureVisible(context,
        duration: const Duration(seconds: 1), curve: Curves.easeInOutSine);
  }
}
