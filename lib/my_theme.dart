import 'package:flutter/material.dart';

class MyTheme {
  /*configurable colors stars*/
  static Color accent_color = const Color.fromRGBO(230, 46, 4, 1.0);
  static Color soft_accent_color = const Color.fromRGBO(247, 189, 168, 1);
  // static Color splash_screen_color = Color.fromRGBO(172, 188, 84, 1);
  static Color splash_screen_color = const Color.fromRGBO(86, 165, 44, 1.0);

  ///Color.fromRGBO(230,46,4, 1); // if not sure , use the same color as accent color
  /*configurable colors ends*/

  /*If you are not a developer, do not change the bottom colors*/
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color light_grey = const Color.fromRGBO(239, 239, 239, 1);
  static Color dark_grey = const Color.fromRGBO(112, 112, 112, 1);
  static Color medium_grey = const Color.fromRGBO(132, 132, 132, 1);
  static Color grey_153 = const Color.fromRGBO(153, 153, 153, 1);
  static Color font_grey = const Color.fromRGBO(73, 73, 73, 1);
  static Color textfield_grey = const Color.fromRGBO(209, 209, 209, 1);
  static Color golden = const Color.fromRGBO(248, 181, 91, 1);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;

  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/

}
