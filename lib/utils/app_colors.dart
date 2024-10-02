import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors{
  
  static Color primaryColor=const Color(0xFFFF8400);
  static Color backgroundColor=const Color(0xFFffffff);
  static Color cardColor = const Color(0xFFFFF3E6);
  static Color cardLightColor = const Color(0xFF555555);
  static Color borderColor = const Color(0xFFFFC68A);
  static Color borderColors = const Color(0xFFFFD9B0);
  static Color textColor = const Color(0xFF222222);
  static Color subTextColor = const Color(0xFF4E4E4E);
  static Color hintColor = const Color(0xFF999999);
  static Color greyColor = const Color(0xFF6B6B6B);
  static Color fillColor = const Color(0xFFFFF3E6);
  static Color dividerColor = const Color(0xFFBABABA);
  static Color shadowColor = const Color(0xFF2B2A2A);
  static Color bottomBarColor = const Color(0xFFFF8400);
  static Color redColor = const Color(0xFFEB5757);
  static Color green = const Color(0xFF27AE60);

  static BoxShadow shadow=BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 2),
  );
}