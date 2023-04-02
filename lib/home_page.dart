import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../awards/awards.dart';
import '../contact/contact.dart';
import '../experience/experience.dart';
import '../portfolio/portfolio.dart';
import '../providers/user_info.dart';
import '../skills/skills.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';
import 'package:sizer/sizer.dart';

import 'about/about.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Scaffold(
            body: Row(
              children: [
                // side menu
                Column(
                  children: [
                    FittedBox(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: getProportionWidth(60),
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: getProportionHieght(160),
                              width: getProportionWidth(40),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                              child: Center(
                                child: Container(
                                    height: getProportionHieght(150),
                                    width: getProportionWidth(38),
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/profile_image.jpg"),
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: getProportionHieght(20),
                            ),
                            TextButton(
                              onPressed: () {
                                _scrollToTop();
                              },
                              child: getTextStyle(
                                  "ABOUT", FontWeight.w500, Colors.white, 20),
                            ),
                            SizedBox(
                              height: getProportionHieght(10),
                            ),
                            TextButton(
                              onPressed: () {
                                _scrollToSection(1);
                              },
                              child: getTextStyle(
                                  "EXPERIENCE", FontWeight.w500, Colors.white, 20),
                            ),
                            SizedBox(
                              height: getProportionHieght(10),
                            ),
                            TextButton(
                              onPressed: () {
                                _scrollToSection(2);
                              },
                              child: getTextStyle(
                                  "PORTFOLIO", FontWeight.w500, Colors.white, 20),
                            ),
                            SizedBox(
                              height: getProportionHieght(10),
                            ),
                            TextButton(
                                onPressed: () {
                                  _scrollToSection(3);
                                },
                                child: getTextStyle(
                                    "SKILLS", FontWeight.w500, Colors.white, 20)),
                            SizedBox(
                              height: getProportionHieght(10),
                            ),
                            TextButton(
                                onPressed: () {
                                  _scrollToSection(4);
                                },
                                child: getTextStyle(
                                    "AWARDS", FontWeight.w500, Colors.white, 20)),
                            SizedBox(
                              height: getProportionHieght(10),
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
                    )
                  ],
                ),
                // body
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      About(),
                      Experience(),
                      Portfolio(),
                      Skills(),
                      Awards(),
                      Contact(),
                    ],
                  ),
                ),
              ],
            ));
      },
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