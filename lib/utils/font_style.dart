import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLies;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextStyle? style;

  const CommonText(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.maxLies,
      this.fontFamily,
      this.style,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return textCommon(context: context);
  }

  Widget textCommon({required BuildContext context}) {
    return Text(
      text,
      // textScaleFactor: ScaleSize.textScaleFactor(context),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLies ?? 8,
      textAlign: textAlign,
      style: style?.copyWith(color: color ?? Theme.of(context).primaryColor) ??
          FontStyles.body.copyWith(color: color ?? Theme.of(context).primaryColor),
    );
  }

  double getFontSize(BuildContext context,
      {double customMobileFontSize = 12.0}) {
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
    } else {
      // For mobile devices
      return mobileFontSize;
    }
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

class FontSizes {
  static const double baseFontSize = 16.0;

  // static double getResponsiveFontSize() {
  //   // Calculate the responsive font size based on the screen width.
  //   double screenWidth = MediaQuery.size.width;
  //   double scaleFactor = screenWidth > 600 ? 1.5 : 1.0;
  //
  //   return baseFontSize * scaleFactor;
  // }

  static const double h1 = 40.0;
  static const double h2 = 36.0;
  static const double h3 = 32.0;
  static const double h4 = 28.0;
  static const double h5 = 24.0;
  static const double h6 = 20.0;
  static const double subheading = 18.0;
  static const double body = 16.0;
  static const double caption = 14.0;
  static const double button = 18.0;
  static const double link = 16.0;
  static const double errorMessage = 14.0;
}

class FontStyles {
  // Font families
  static const String headingFontFamily = 'Poppins';
  static const String subheadingFontFamily = 'OpenSans';
  static const String bodyFontFamily = 'Roboto';
  static const String captionFontFamily = 'Lora';

  static final TextStyle heading1 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h1,
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    height: 1.2,
    shadows: [
      Shadow(
        color: Colors.grey.shade400,
        blurRadius: 2,
        offset: const Offset(1, 1),
      ),
    ],
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h2,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h3,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h4,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.2,
  );

  static const TextStyle heading5 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h5,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.2,
  );

  static const TextStyle heading6 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.h6,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: subheadingFontFamily,
    fontSize: FontSizes.subheading,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: FontSizes.body,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: captionFontFamily,
    fontSize: FontSizes.caption,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: FontSizes.button,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  static const TextStyle link = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: FontSizes.link,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  static const TextStyle errorMessage = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: FontSizes.errorMessage,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
}
