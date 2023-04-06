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
    return Consumer<UserInfo>(builder: (context, provider, child) {
      provider.removeLastNameOnUser();
      return Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(
              image: AssetImage("assets/backGround-image.jpg"),
              fit: BoxFit.fill,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FittedBox(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Container(
              //         height: 100,
              //         width: 40,
              //         decoration: const BoxDecoration(
              //           // borderRadius: BorderRadius.all(Radius.circular(100)),
              //             image: DecorationImage(
              //               image:
              //               AssetImage("assets/profile_logo.jpg"),
              //               fit: BoxFit.fill,
              //             )),
              //       ),
              //       const SizedBox(
              //         width: 3,
              //       ),
              //       getTextStyle("profile", FontWeight.bold,
              //           Colors.blue, 50),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              FittedBox(
                child: Row(
                  children: [
                    getTextStyle(provider.userFirstName.toUpperCase(),
                        FontWeight.bold, Colors.white, 70),
                    const SizedBox(
                      width: 5,
                    ),
                    getTextStyle(
                        provider.user.split(' ').last.toUpperCase(), FontWeight.bold, Colors.blue, 70),
                  ],
                ),
              ),
              FittedBox(
                child: getTextStyle(
                    provider.smallTagline,
                    FontWeight.bold,
                    Colors.white54,
                    20),
              ),
              const SizedBox(
                height: 30,
              ),
              // please do not use static padding, please found alternate here
              Padding(
                padding: const EdgeInsets.only(right: 700.0),
                child: getTextStyle(
                  provider.bigTagline,
                    FontWeight.normal,
                    Colors.white38,
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
