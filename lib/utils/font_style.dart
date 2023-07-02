import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamily;
  final TextAlign? textAlign;


  const CommonText({super.key, required this.text, this.color, this.fontWeight, this.fontSize, this.fontFamily, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final double customFontSize = getFontSize(context, customMobileFontSize: fontSize ?? 10);
    // return ResponsiveWidget(
    //   mobile: textCommon(context:context, fontSize: customFontSize),
    //   tablet: textCommon(context:context, fontSize: customFontSize),
    //   desktop: textCommon(context:context, fontSize: customFontSize),
    // );
    return textCommon(context:context, fontSize: customFontSize);
  }
  Widget textCommon({required BuildContext context, required double fontSize}){
    return Text(
      text,
      textScaleFactor: ScaleSize.textScaleFactor(context),
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).primaryColor,
          fontSize: fontSize,
          fontFamily: fontFamily ?? CommonFonts.frederickatheGreat
      ),
    );
  }
  double getFontSize(BuildContext context, {double customMobileFontSize = 12.0}) {
    final screenWidth = MediaQuery.of(context).size.width;

    double mobileFontSize = customMobileFontSize;
    double tabletFontSize = mobileFontSize * 1.25; // Scale up by 25%
    double desktopFontSize = mobileFontSize * 1.5; // Scale up by 50%

    if (screenWidth >= 600 && screenWidth < 1200) {
      // For tablet devices
      return tabletFontSize;
    } else if (screenWidth >= 1200) {
      // For desktop devices
      return desktopFontSize;
    }else{

    // For mobile devices
    return mobileFontSize;}
  }

}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class CommonFonts {
  static String baroneysSolid = 'BaroneysSolid';
  static String baroneysTextured = 'BaroneysTextured';
  static String diamondaRegular = 'DiamondaRegular';
  static String frederickatheGreat = 'FrederickatheGreat';
  static String goldentext = 'goldentext';
  static String holystaindemo = 'Holystaindemo';
  static String holystainOutline = 'HolystainOutline';
  static String natureBeauty = 'NatureBeauty';
  static String roosterF = 'RoosterF';
  static String serenityMomentRegular = 'SerenityMomentRegular';
  static String stonedpersonaluseBold = 'StonedpersonaluseBold';
  static String theWeddingSignatureRegular = 'TheWeddingSignatureRegular';
}
