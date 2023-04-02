import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  var searchTerm = "";
  var isSearching = false;

  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    return Consumer<UserInfo>(builder: (context, provider, child) {
      return Container(
        height: getProportionHieght(812),
        width: getProportionWidth(315),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(
              image: AssetImage("assets/background_image.jpg"),
              fit: BoxFit.fill,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionHieght(100),
                      width: getProportionWidth(40),
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                            image:
                            AssetImage("assets/profile_logo.jpg"),
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      width: getProportionWidth(3),
                    ),
                    getTextStyle("profile", FontWeight.bold,
                        Colors.blue, 50),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FittedBox(
                child: Row(
                  children: [
                    getTextStyle("${provider.user.toUpperCase()}",
                        FontWeight.bold, Colors.black, 70),
                    SizedBox(
                      width: getProportionWidth(5),
                    ),
                    getTextStyle(
                        "BONSEN", FontWeight.bold, Colors.blue, 70),
                  ],
                ),
              ),
              FittedBox(
                child: Row(
                  children: [
                    getTextStyle(
                        "THE NEXT BIG IDEA IS WAITING FOR ITS NEXT BIG CHANGER WITH ",
                        FontWeight.bold,
                        Colors.black45,
                        20),
                    SizedBox(
                      width: getProportionWidth(1),
                    ),
                    getTextStyle("THEMSBIT", FontWeight.bold,
                        Colors.blue, 20),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 700.0),
                child: getTextStyle(
                    "I am experienced in leveraging agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.",
                    FontWeight.normal,
                    Colors.black38,
                    20),
              ),
              const SizedBox(
                height: 50,
              ),
              FittedBox(
                child: Row(
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      iconSize: 40,
                      onPressed: () {
                        setState(
                              () {
                            Navigator.pop(context);
                            isSearching = false;
                            searchTerm = "";
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      onPressed: () {
                        setState(
                              () {
                            Navigator.pop(context);
                            isSearching = false;
                            searchTerm = "";
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {
                        setState(
                              () {
                            Navigator.pop(context);
                            isSearching = false;
                            searchTerm = "";
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onPressed: () {
                        setState(
                              () {
                            Navigator.pop(context);
                            isSearching = false;
                            searchTerm = "";
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
