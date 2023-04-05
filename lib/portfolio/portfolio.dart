import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'dart:io';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

Widget gridView(List<String> images) {
  return SizedBox(
    height: getProportionHieght(750),
    width: getProportionWidth(250),
    child: GridView.builder(
      itemCount: images.length,
      physics: const NeverScrollableScrollPhysics(),
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
  bool _allButtonhour2 = false;
  bool _allButtonhour3 = false;
  bool _allButtonhour4 = false;

  set isHover(bool isHover) {}

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
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        provider.imagesListModifiying();
        return provider.pImages.isNotEmpty
            ? Column(children: [
                const SizedBox(
                  height: (50),
                ),
                getTextStyle("Portfolio", FontWeight.bold, Colors.black, 50),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: (6),
                  width: (120),
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: (50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(
                            width: 1,
                            color: Colors.blueAccent,
                          ),
                        ),
                        child: TextButton(
                            onHover: (val) {},
                            onPressed: () {
                              provider.imagesListModifiying();
                            },
                            child: Text(
                              'ALL',
                              style: GoogleFonts.abyssinicaSil(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )),
                      ),
                    ),
                    for (int c = 0; c < provider.imagesKeys.length; c++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          // width: (36),
                          // height: (40),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: TextButton(
                              onHover: (val) {},
                              onPressed: () {
                                provider.imageFilter(provider.imagesKeys[c]);
                              },
                              child: Text(
                                '${provider.imagesKeys[c]}'.toUpperCase(),
                                style: GoogleFonts.abyssinicaSil(
                                    textStyle: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20)),
                              )),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: (35),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: provider.pImages.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.0,
                            childAspectRatio: 2,
                            mainAxisSpacing: 18.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.network(
                          provider.pImages[index]['img'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ])
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
