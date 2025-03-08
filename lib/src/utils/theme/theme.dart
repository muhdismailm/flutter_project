import 'package:flutter/material.dart';
class TAppTheme{
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom())
  );
  static ThemeData dartTheme = ThemeData(brightness: Brightness.dark);
}