import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:io';

import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Portfolio extends StatefulWidget {
  @override
  State<Portfolio> createState() => _PortfolioState();
}

Widget gridView(int itemCounts, List<String> images) {
  return SizedBox(
    height: getProportionHieght(550),
    width: getProportionWidth(250),
    child: GridView.builder(
      itemCount: itemCounts,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // height: 50,
          // width: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    ),
  );
}

class _PortfolioState extends State<Portfolio> {
  bool _showAllImages = true;
  bool _showWebDesignImages = false;
  bool _showMobileAppImages = false;
  bool _showGraphicDesignImages = false;

  //hover button variable, it will help us to find allbutton hover state
  bool _allButtonhour = false;

  void allImages() {
    setState(() {
      if (_showAllImages == false) {
        _showAllImages = true;
        _showWebDesignImages = false;
        _showMobileAppImages = false;
        _showGraphicDesignImages = false;
      }
    });
  }

  void webDesignImages() {
    setState(() {
      if (_showWebDesignImages == false) {
        _showAllImages = false;
        _showMobileAppImages = false;
        _showGraphicDesignImages = false;
        _showWebDesignImages = true;
      }
    });
  }

  void mobileAppImages() {
    setState(() {
      if (_showMobileAppImages == false) {
        _showAllImages = false;
        _showMobileAppImages = true;
        _showWebDesignImages = false;
        _showGraphicDesignImages = false;
      }
    });
  }

  void graphicDesignImages() {
    setState(() {
      if (_showGraphicDesignImages == false) {
        _showAllImages = false;
        _showMobileAppImages = false;
        _showWebDesignImages = false;
        _showGraphicDesignImages = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizexGet().init(context);
    return Container(
        height: getProportionHieght(812),
        width: getProportionWidth(315),
        color: Colors.grey[200],
        child: Column(children: [
          // SizedBox(
          //   height: getProportionHieght(50),
          // ),
          getTextStyle("Portfolio", FontWeight.bold, Colors.black, 50),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: getProportionHieght(6),
            width: getProportionWidth(20),
            color: Colors.blue,
          ),
          SizedBox(
            height: getProportionHieght(60),
          ),
          FittedBox(
            child: Row(
              children: [
                Container(
                  width: getProportionWidth(16),
                  height: getProportionHieght(35),
                  decoration: BoxDecoration(
                    color: _allButtonhour == true ? Colors.blueAccent : null,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                    ),
                  ),
                  child: FittedBox(
                    child: TextButton(
                        onPressed: allImages,
                        child: AutoSizeText(
                          "ALL",
                          style: GoogleFonts.abyssinicaSil(
                              textStyle: TextStyle(
                                  color: _allButtonhour == true
                                      ? Colors.amber
                                      : Colors.blueAccent,
                                  fontSize: 20)),
                        )),
                  ),
                ),
                SizedBox(
                  width: getProportionWidth(5),
                ),
                Container(
                  width: getProportionWidth(26),
                  height: getProportionHieght(35),
                  decoration: BoxDecoration(
                    color: _allButtonhour == true ? Colors.blueAccent : null,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                    ),
                  ),
                  child: TextButton(
                      onPressed: webDesignImages,
                      child: AutoSizeText(
                        "WEB DESIGN",
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                                color: _allButtonhour == true
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                fontSize: 20)),
                      )),
                ),
                SizedBox(
                  width: getProportionWidth(5),
                ),
                Container(
                  width: getProportionWidth(30),
                  height: getProportionHieght(35),
                  decoration: BoxDecoration(
                    color: _allButtonhour == true ? Colors.blueAccent : null,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                    ),
                  ),
                  child: TextButton(
                      onPressed: mobileAppImages,
                      child: AutoSizeText(
                        "MOBILE APP",
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                                color: _allButtonhour == true
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                fontSize: 20)),
                      )),
                ),
                SizedBox(
                  width: getProportionWidth(5),
                ),
                Container(
                  width: getProportionWidth(36),
                  height: getProportionHieght(35),
                  decoration: BoxDecoration(
                    color: _allButtonhour == true ? Colors.blueAccent : null,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                    ),
                  ),
                  child: TextButton(
                      onPressed: graphicDesignImages,
                      child: AutoSizeText(
                        "GRAPHICS DESIGN",
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                                color: _allButtonhour == true
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                fontSize: 20)),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionHieght(35),
          ),
          _showAllImages
              ? gridView(4, [
                  "https://picsum.photos/200",
                  "https://picsum.photos/200",
                  "https://picsum.photos/200",
                  "https://picsum.photos/200"
                ])
              : const SizedBox(),
          _showWebDesignImages
              ? gridView(1, ["https://picsum.photos/200"])
              : const SizedBox(),
          _showMobileAppImages
              ? gridView(3, [
                  "https://picsum.photos/200",
                  "https://picsum.photos/200",
                  "https://picsum.photos/200"
                ])
              : const SizedBox(),
          _showGraphicDesignImages
              ? gridView(
                  2, ["https://picsum.photos/200", "https://picsum.photos/200"])
              : const SizedBox(),
        // SizedBox(height: getProportionHieght(50),)
        ]));
  }
}
