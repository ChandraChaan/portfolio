import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:provider/provider.dart';
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
      mobile: mobileUI(context),
      tablet: tabletUI(context),
      desktop: deskTopUI(context),
    );
  }

  Widget deskTopUI(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,

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
                Consumer<UserInfo>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        Transform.scale(
                            scale: 1,
                            child: Switch(
                              onChanged: (bool newVal) {
                                provider.changeThemeMode();
                              },
                              value: provider.themeLightMode,
                              activeColor: Colors.pink,
                              activeTrackColor: Colors.yellow,
                              inactiveThumbColor: Colors.black87,
                              inactiveTrackColor: Colors.purple,
                            )),
                        Text('Theme was : ${provider.themeLightMode ? 'Light mode':'Dark mode'}',style: styl)
                      ],
                    );
                  },
                ),
                SizedBox(height: 50,),
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
                  child: Text("ABOUT", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(expScrollKey.currentContext!);
                  },
                  child: Text("EXPERIENCE", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(portfoScrollKey.currentContext!);
                  },
                  child: Text("PORTFOLIO", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(skillScrollKey.currentContext!);
                  },
                  child: Text("SKILLS", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(projectsScrollKey.currentContext!);
                    },
                    child: Text("PROJECTS", style: styl)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(contactScrollKey.currentContext!);
                    },
                    child: Text("CONTACT", style: styl)),
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

  Widget tabletUI(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawerMobile(context),
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

  Widget mobileUI(BuildContext context) {
    // TextStyle? styl = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawerMobile(context),
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
                  child: Text("ABOUT", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(expScrollKey.currentContext!);
                  },
                  child: Text("EXPERIENCE", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(portfoScrollKey.currentContext!);
                  },
                  child: Text("PORTFOLIO", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    srollSmooth(skillScrollKey.currentContext!);
                  },
                  child: Text("SKILLS", style: styl),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(projectsScrollKey.currentContext!);
                    },
                    child: Text("PROJECTS", style: styl)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      srollSmooth(contactScrollKey.currentContext!);
                    },
                    child: Text("CONTACT", style: styl)),
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
