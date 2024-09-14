import 'package:flutter/material.dart';

class ScreenSizeConfig {
  static late double ScreenWidth;
  static late double ScreenHeight;
  static String? fontfamilytittle;
  static String? fontfamilyRegular;
  static late double iconSize;
  static late double titleTextsize;
  static const double defaultPadding = 30.0;
 static late Color customwhite ;
  static late Color customblack ;
   static late Color customgrey ;
 static late Color primarycolor ;

  static void init(BuildContext context) {
    ScreenWidth = MediaQuery.of(context).size.width;
    ScreenHeight = MediaQuery.of(context).size.height;
    iconSize = ScreenWidth * 0.07;
    fontfamilytittle = "Merriweather";
    fontfamilyRegular = "Dosis";
    customwhite = Colors.white;
    primarycolor = Colors.indigo ;
    customblack = Colors.black;
 customgrey = Color(0xffF2F2F2);
  }
}
