import 'package:flutter/material.dart';

class MyThemData {
  static Color primiryColor = Color(0Xff5D9CEC);
  static Color accentColor = Color(0XffDFECDE);
  static Color primiryColorDark = Color(0Xff5D9CEC);
  static Color accentColorDark = Color(0Xff060E1E);
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor:Colors.pink,
    primaryColor: primiryColor,
    accentColor: accentColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.red,
      toolbarHeight: 100,
      titleTextStyle:const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: primiryColorDark),
    textTheme:const TextTheme(
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.black),
      titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
      displayMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      displaySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xffA9A9A9)),
      bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff353535)),
      bodyMedium:  TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),

    )
    );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primiryColorDark,
    accentColor: accentColorDark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black12,
      titleTextStyle:TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primiryColor

    ),
    scaffoldBackgroundColor: Colors.blueGrey,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: MyThemData.primiryColorDark,
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      headline4: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
