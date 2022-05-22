import 'package:flutter/material.dart';

class Themes {
  static final darktheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.grey.shade900,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.dark());

  static final lighttheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.light());
}
