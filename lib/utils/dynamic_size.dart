import 'package:flutter/material.dart';


class SizexGet {
  static MediaQueryData? _mediaQueryData;
  static double? screenwidth;
  static double? screenheight;
  static double? defaultsize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenheight = _mediaQueryData!.size.height;
    screenwidth = _mediaQueryData!.size.width;
    orientation = _mediaQueryData!.orientation;
  }
}

double getProportionHieght(double inputhieght) {
  double? screeHights = SizexGet.screenheight;
  return (inputhieght / 812.0) * screeHights!;
}

double getProportionWidth(double inputwidth) {
  double? screenwidths = SizexGet.screenwidth;
  return (inputwidth / 375.0) * screenwidths!;
}