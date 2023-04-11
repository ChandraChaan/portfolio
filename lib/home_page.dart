import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import '../projects/projects.dart';
import '../contact/contact.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../skills/skills.dart';
import '../utils/font_style.dart';

import 'about/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _scrollController = ScrollController();

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
                    _scrollToTop();
                  },
                  child:
                      getTextStyle("ABOUT", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(1);
                  },
                  child: getTextStyle(
                      "EXPERIENCE", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(2);
                  },
                  child: getTextStyle(
                      "PORTFOLIO", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(3);
                  },
                  child:
                      getTextStyle("SKILLS", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _scrollToSection(4);
                    },
                    child: getTextStyle(
                        "PROJECTS", FontWeight.w500, Colors.white, 20)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _scrollToSection(5);
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
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                About(),
                Experience(
                  smallCard: false,
                ),
                Portfolio(smallCard: false,),
                Skills(),
                Awards(smallCard: false,),
                Contact(),
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
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          About(),
          Experience(
            smallCard: false,
          ),
          Portfolio(smallCard: false,),
          Skills(),
          Awards(smallCard: false,),
          Contact(),
        ],
      ),
    ));
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
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          About(),
          Experience(
            smallCard: true,
          ),
          Portfolio(smallCard: true,),
          Skills(),
          Awards(smallCard: true,),
          Contact(),
        ],
      ),
    ));
  }

  Drawer drawerMobile () {
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
                    _scrollToTop();
                  },
                  child:
                  getTextStyle("ABOUT", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(1);
                  },
                  child: getTextStyle(
                      "EXPERIENCE", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(2);
                  },
                  child: getTextStyle(
                      "PORTFOLIO", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    _scrollToSection(3);
                  },
                  child:
                  getTextStyle("SKILLS", FontWeight.w500, Colors.white, 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _scrollToSection(4);
                    },
                    child: getTextStyle(
                        "AWARDS", FontWeight.w500, Colors.white, 20)),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _scrollToSection(5);
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
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToSection(int sectionIndex) {
    final sectionPosition = sectionIndex * MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      sectionPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
