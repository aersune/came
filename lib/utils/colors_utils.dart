import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', "");
  if(hexColor.length ==6){
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}


class AppColor {
  static  Color mainColor = const Color(0xff039d8f);
  static  Color secondColor = const Color(0xff64c987);
}