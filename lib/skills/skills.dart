import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/constants.dart';
import '../utils/font_style.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            // height: (1000),
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1512429234305-12fe5b0b0f07?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
              ),
              //AssetImage("assets/skills_images.jpg"),
              fit: BoxFit.fill,
            )),
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Column(
                children: [
                  const CommonText(text: "CODING SKILLS", style: FontStyles.heading4,),
                  Wrap(
                    children: [
                      for (int i = 0; i < Constants.skillData.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 100,
                            color: Colors.grey.withOpacity(0.6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "${Constants.skillData[i]["icon"]}",
                                    height: 30,
                                    width: 30,
                                  ),
                                  CommonText(text: "${Constants.skillData[i]["score"]}",style: FontStyles.body,),
                                  CommonText(text: "${Constants.skillData[i]["name"]}", style: FontStyles.body),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // FittedBox(
                      //   child: Container(
                      //     height: getProportionHieght(170),
                      //     width: getProportionWidth(70),
                      //     color: Colors.grey.withOpacity(0.6),
                      //     child: FittedBox(
                      //       child: Column(
                      //         children: [
                      //           IconButton(
                      //             onPressed: () {},
                      //             icon: const FaIcon(FontAwesomeIcons.css3),
                      //             iconSize: 100,
                      //             color: Colors.blue,
                      //           ),
                      //           getTextStyle("95%", FontWeight.bold, Colors.black, 35),
                      //           getTextStyle("CSS", FontWeight.normal, Colors.black, 23)
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // FittedBox(
                      //   child: Container(
                      //     height: getProportionHieght(170),
                      //     width: getProportionWidth(70),
                      //     color: Colors.grey.withOpacity(0.6),
                      //     child: FittedBox(
                      //       child: Column(
                      //         children: [
                      //           IconButton(
                      //             onPressed: () {},
                      //             icon: const FaIcon(FontAwesomeIcons.jsSquare),
                      //             iconSize: 100,
                      //             color: Colors.blue,
                      //           ),
                      //           getTextStyle("65%", FontWeight.bold, Colors.black, 35),
                      //           getTextStyle(
                      //               "JQuery", FontWeight.normal, Colors.black, 23)
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // FittedBox(
                      //   child: Container(
                      //     height: getProportionHieght(170),
                      //     width: getProportionWidth(70),
                      //     color: Colors.grey.withOpacity(0.6),
                      //     child: FittedBox(
                      //       child: Column(
                      //         children: [
                      //           IconButton(
                      //             onPressed: () {},
                      //             icon: const FaIcon(FontAwesomeIcons.earthAmericas),
                      //             iconSize: 100,
                      //             color: Colors.blue,
                      //           ),
                      //           getTextStyle("89%", FontWeight.bold, Colors.black, 35),
                      //           getTextStyle("PHP", FontWeight.normal, Colors.black, 23)
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            // color: Colors.amber,
          ),
        );
      },
    );
  }
}
