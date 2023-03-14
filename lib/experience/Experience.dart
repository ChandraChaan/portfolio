import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                            getTextStyle("Senior Web Developer", FontWeight.bold, Colors.black, 25)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextStyle("Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional click through from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.", FontWeight.normal, Colors.black45, 17),
                      const SizedBox(
                        height: 20,
                      ),
                      // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: getProportionWidth(95),),
                            getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18)
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
                    color: Colors.amberAccent,
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
                            getTextStyle("Web Developer", FontWeight.bold, Colors.black, 25)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextStyle("Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional click through from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.", FontWeight.normal, Colors.black45, 17),
                      const SizedBox(
                        height: 20,
                      ),
                      // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: getProportionWidth(95),),
                            getTextStyle("December 2018 - March 2019", FontWeight.normal, Colors.blue, 18)
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
                    color: Colors.green,
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
                            getTextStyle("Junior Web Designer", FontWeight.bold, Colors.black, 25)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextStyle("Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional click through from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.", FontWeight.normal, Colors.black45, 17),
                      const SizedBox(
                        height: 20,
                      ),
                      // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: getProportionWidth(95),),
                            getTextStyle("July 2017 - December 2018", FontWeight.normal, Colors.blue, 18)
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
                    color: Colors.lightBlueAccent,
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
                            getTextStyle("Web Design Intern", FontWeight.bold, Colors.black, 25)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextStyle("Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional click through from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.", FontWeight.normal, Colors.black45, 17),
                      const SizedBox(
                        height: 20,
                      ),
                      // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: getProportionWidth(95),),
                            getTextStyle("September 2018 - June 2019", FontWeight.normal, Colors.blue, 18)
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
  }
}
