import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getTextStyle(
    String text, FontWeight fontWeight, Color color, double fontSizes) {
  return AutoSizeText(
    text,
    style: GoogleFonts.abyssinicaSil(
      textStyle:
          TextStyle(fontWeight: fontWeight, color: color, fontSize: fontSizes),
    ),
    // maxLines: 4,
    // minFontSize: 10.0,
    // stepGranularity: 1.0,
  );
}

class CommonText extends StatelessWidget {
  final String text;

  const CommonText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
          fontFamily: 'FrederickatheGreat'),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}