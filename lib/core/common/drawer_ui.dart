import 'package:flutter/material.dart';
import 'package:portfoli_web/core/common/scroll.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info.dart';
import '../../utils/font_style.dart';

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
              // themeCOlorChange(),
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
                child: CommonText(
                    text: 'ABOUT',
                    color: isAboutVisible
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
                    color: isExpVisible
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
                    color: isPortfoVisible
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
                    color: isSkillsVisible
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
                      color: isProjectsVisible
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
                    color: isContactVisible
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
