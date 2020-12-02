import 'package:blogr_app/constants/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: CustomColors.blackColor,
      backgroundColor: Colors.white70,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: CustomColors.blackColor,
      backgroundColor: Colors.white70,
    ),
  );
}