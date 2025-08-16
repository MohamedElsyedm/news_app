import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xff171717);
  static const Color white = Color(0xffffffff);
  static const Color grey = Color(0xffA0A0A0);

  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: black,

    appBarTheme: AppBarTheme(
      backgroundColor: black,
      foregroundColor: white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: white,
      ),
    ),
  );
}
