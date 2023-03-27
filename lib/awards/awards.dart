import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';


import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Awards extends StatefulWidget {
  @override
  _AwardsState createState() => _AwardsState();
}

class _AwardsState extends State<Awards> {
  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    return Container(
      height: getProportionHieght(670),
      width: getProportionWidth(315),
      color: Colors.grey[200],
      child: Column(
        children: [
          SizedBox(height: getProportionHieght(100),),
          getTextStyle("AWARDS", FontWeight.bold, Colors.black, 50),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: getProportionHieght(6),
            width: getProportionWidth(20),
            color: Colors.blue,
          ),
          const SizedBox(height: 70.0,),
    TimelineTile(
    alignment: TimelineAlign.center,
    lineXY: 0.2,
    endChild: Container(
      child:           Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    SizedBox(width: getProportionWidth(10),),
    Container(
    height: getProportionHieght(220),
    width: getProportionWidth(125),
    color: Colors.white,
    child: Padding(
    padding: const EdgeInsets.only(right: 20.0,top: 20.0,bottom: 20.0,left: 60.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    FittedBox(
    child: getTextStyle(
    "Apr 2017 - Mar 2018", FontWeight.normal, Colors.blue, 19),
    ),
    const SizedBox(height: 10,),
    FittedBox(
    child: getTextStyle(
    "Google Analytics Certified Developer", FontWeight.bold,
    Colors.black, 19),
    ),
    const SizedBox(height: 10,),
    AutoSizeText(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mattis felis vitae risus pulvinar tincidunt. Nam ac venenatis enim. Aenean hendrerit justo sed. ",
    style: GoogleFonts.abyssinicaSil(
    textStyle: const TextStyle(
    fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 19),
    ),
    textAlign: TextAlign.right,maxLines: 3,minFontSize: 10,),
    ],
    ),
    ),
    ),
    ],
    ),

    constraints: const BoxConstraints(
    minHeight: 170,
    ),
      color: Colors.white,
    ),
    startChild: Container(
      child:     Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: getProportionHieght(245),
            width: getProportionWidth(125),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 60.0,top: 20.0,bottom: 20.0,left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: getTextStyle(
                        "Apr 2018 - Mar 2019", FontWeight.normal, Colors.blue, 19),
                  ),
                  const SizedBox(height: 10,),
                  FittedBox(
                    child: getTextStyle(
                        "Mobile Web Specialist - Google Certification", FontWeight.bold,
                        Colors.black, 19),
                  ),
                  const SizedBox(height: 10,),
                  getTextStyle(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mattis felis vitae risus pulvinar tincidunt. Nam ac venenatis enim. Aenean hendrerit justo sed. ", FontWeight.normal, Colors.black45, 19),
                ],
              ),
            ),
          ),
          // const SizedBox(width: 50,),
        ],
      ),

    color: Colors.white,
    ),
    ),


        ],
      ),
    );
  }
}
