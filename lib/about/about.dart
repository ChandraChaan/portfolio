import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/user_info.dart';
import 'dart:html' as html;
import '../utils/font_style.dart';

class About extends StatefulWidget {
  final bool mobileImg;
  final bool tabImg;

  const About({super.key, this.mobileImg = false, this.tabImg = false});

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
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(
          image: AssetImage(widget.mobileImg
              ? (widget.tabImg
                  ? 'assets/mobile_tab.jpg'
                  : 'assets/mobile_bc.jpg')
              : 'assets/backGround-image.jpg'),
          fit: /*widget.mobileImg? BoxFit.fitHeight:*/ BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              FittedBox(
                child: Row(
                  children: [
                    CommonText(
                      text: provider.userFirstName.toUpperCase(),
                      style: FontStyles.heading1,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CommonText(
                      text: provider.user.split(' ').last.toUpperCase(),
                      color: Theme.of(context).indicatorColor,
                      style: FontStyles.heading1,
                    ),
                  ],
                )
                    .animate()
                    .flip(duration: const Duration(seconds: 3))
                    .shake()
                    .then(),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child:  CommonText(
                      text: provider.smallTagline,
                      style: FontStyles.heading6,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ).animate().scale(),
              const SizedBox(
                height: 30,
              ),
              // please do not use static padding, please found alternate here
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonText(
                      text: provider.bigTagline,
                      style: FontStyles.caption,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  IconButton(
                    color: Theme.of(context).backgroundColor,
                    icon: const FaIcon(FontAwesomeIcons.github),
                    // iconSize: 40,
                    onPressed: () {
                      html.window
                          .open('https://github.com/ChandraChaan', 'new tab');

                      // https://github.com/ChandraChaan
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      color: Theme.of(context).backgroundColor,
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      // iconSize: 40,
                      onPressed: () {
                        html.window.open(
                            'https://www.linkedin.com/in/chandra-obul-reddy-dumpala-a7ba6415a/',
                            'new tab');
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      color: Theme.of(context).backgroundColor,
                      icon: const FaIcon(
                        FontAwesomeIcons.stackOverflow,
                      ),
                      // iconSize: 40,
                      onPressed: () {
                        html.window.open(
                            'https://stackoverflow.com/users/16990621/chandra-chaan',
                            'new tab');
                      }
                      // https://www.linkedin.com/in/chandra-obul-reddy-dumpala-a7ba6415a/                      },
                      ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
