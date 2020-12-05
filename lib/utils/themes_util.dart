import 'package:blogr_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData light = ThemeData(
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 30,
          color: CustomColors.darkColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(
        color: CustomColors.blackColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 15,
      unselectedItemColor: Colors.grey,
      selectedItemColor: CustomColors.blackColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: CustomColors.blackColor,
      backgroundColor: Colors.white70,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: CustomColors.blackColor,
      ),
      headline2: TextStyle(
        color: CustomColors.greyColor,
      ),
      headline3: TextStyle(
        color: CustomColors.greyColor,
      ),
    ),
    cardColor: Colors.grey.withOpacity(0.3), // Profile & Fav Screens card
    cardTheme: CardTheme(color: Colors.grey[300]), // Articles Screen card
  );

  static final ThemeData dark = ThemeData(
    backgroundColor: CustomColors.darkColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 15,
      backgroundColor: CustomColors.bottomBarColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: CustomColors.blackColor,
    ),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: CustomColors.bottomBarColor,
      backgroundColor: CustomColors.greyColor,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.white60,
      ),
      headline3: TextStyle(
        color: CustomColors.greyColor,
      ),
    ),
    cardColor: CustomColors.bottomBarColor
        .withOpacity(0.8), // Profile & Fav screens card
    cardTheme: CardTheme(
      color:
          CustomColors.bottomBarColor.withOpacity(0.9), // Articles Screen card
    ),
  );
}
