import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';



class Skills extends StatefulWidget {
  @override
  State<Skills> createState() => _SkillsState();

}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    var percent;

    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Container(
          width: getProportionWidth(315),
          height: getProportionHieght(1000),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(100)),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1512429234305-12fe5b0b0f07?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',),
                //AssetImage("assets/skills_images.jpg"),
                fit: BoxFit.fill,
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              children: [
                const Text(
                  'CODING SKILLS',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                Wrap(
                  children: [
                    for(int i=0; i< provider.skillData.length;i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 210,
                          width: 170,
                          color: Colors.grey.withOpacity(0.6),
                          child: Column(
                            children: [
                              const Icon(
                                FontAwesomeIcons.html5,
                                size: 100,
                                color: Colors.blue,
                              ),
                              getTextStyle("${provider.skillData[i]["score"]}", FontWeight.bold, Colors.black, 35),
                              getTextStyle(
                                  "${provider.skillData[i]["name"]}", FontWeight.normal, Colors.black, 23)
                            ],
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
              ],
            ),
          ),
          // color: Colors.amber,
        );
      },
    );

  }
}
