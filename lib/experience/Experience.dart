import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Experience extends StatefulWidget {
  static var length;

  @override
  State<Experience> createState() => _ExperienceState();

}

class _ExperienceState extends State<Experience> {
  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Container(

            height: getProportionHieght(812),
            width: getProportionWidth(315),
            color: Colors.grey[200],
            child: Column(children: [
              SizedBox(
                height: getProportionHieght(50),
              ),
              getTextStyle("EXPERIENCE", FontWeight.bold, Colors.black, 50),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: getProportionHieght(6),
                width: getProportionWidth(20),
                color: Colors.blue,
              ),
              SizedBox(height: getProportionHieght(40),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getProportionHieght(243),
                    width: getProportionWidth(140),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          // blurRadius: 100,
                          spreadRadius: 0.5,
                          offset: Offset(1.5, 1.5),
                        )
                      ],
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.earth,
                                  color: Colors.blueAccent,
                                  size: 27,
                                ),
                                SizedBox(width: getProportionWidth(5),),
                                getTextStyle("${provider.expData[0]["title"]}", FontWeight.bold, Colors.black, 25)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          getTextStyle("${provider.expData[0]["summary"]}", FontWeight.normal, Colors.black45, 17),
                          const SizedBox(
                            height: 20,
                          ),
                          // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: getProportionWidth(95),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    getTextStyle("${provider.expData[0]["startDate"]}", FontWeight.normal, Colors.blue, 18),
                                    getTextStyle("${provider.expData[0]["present"]}", FontWeight.normal, Colors.blue, 18),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionHieght(243),
                    width: getProportionWidth(140),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          // blurRadius: 100,
                          spreadRadius: 0.5,
                          offset: Offset(1.5, 1.5),
                        )
                      ],
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.laptop,
                                  color: Colors.amberAccent,
                                  size: 27,
                                ),

                                SizedBox(width: getProportionWidth(5),),
                                getTextStyle("${provider.expData1[0]["title1"]}", FontWeight.bold, Colors.black, 25)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          getTextStyle("${provider.expData1[0]["summary1"]}", FontWeight.normal, Colors.black45, 17),
                          const SizedBox(
                            height: 20,
                          ),
                          // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: getProportionWidth(95),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    getTextStyle("${provider.expData1[0]["startDate1"]}", FontWeight.normal, Colors.blue, 18),
                                    getTextStyle("${provider.expData1[0]["endDate1"]}", FontWeight.normal, Colors.blue, 18),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionHieght(45),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getProportionHieght(243),
                    width: getProportionWidth(140),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          // blurRadius: 100,
                          spreadRadius: 0.5,
                          offset: Offset(1.5, 1.5),
                        )
                      ],
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.green,
                                  size: 27,
                                ),


                                SizedBox(width: getProportionWidth(5),),
                                getTextStyle("${provider.expData2[0]["title2"]}", FontWeight.bold, Colors.black, 25)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          getTextStyle("${provider.expData2[0]["summary2"]}", FontWeight.normal, Colors.black45, 17),
                          const SizedBox(
                            height: 20,
                          ),
                          // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: getProportionWidth(95),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    getTextStyle("${provider.expData2[0]["startDate2"]}", FontWeight.normal, Colors.blue, 18),
                                    getTextStyle("${provider.expData2[0]["endDate2"]}", FontWeight.normal, Colors.blue, 18),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionHieght(243),
                    width: getProportionWidth(140),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          // blurRadius: 100,
                          spreadRadius: 0.5,
                          offset: Offset(1.5, 1.5),
                        )
                      ],
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.images,
                                  color: Colors.lightBlueAccent,
                                  size: 27,
                                ),



                                SizedBox(width: getProportionWidth(5),),
                                getTextStyle("${provider.expData3[0]["title3"]}", FontWeight.bold, Colors.black, 25)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          getTextStyle("${provider.expData3[0]["summary3"]}", FontWeight.normal, Colors.black45, 17),
                          const SizedBox(
                            height: 20,
                          ),
                          // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: getProportionWidth(95),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    getTextStyle("${provider.expData3[0]["startDate3"]}", FontWeight.normal, Colors.blue, 18),
                                    getTextStyle("${provider.expData3[0]["endDate3"]}", FontWeight.normal, Colors.blue, 18),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              )
            ]));

      },
    );

  }
}
