import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  colorScheme: ColorScheme(
    primary: Colors.black,
    secondary: Colors.yellow[700]!,
    surface: const Color(0xFF212121),
    background: const Color(0xFF212121),
    onPrimary: Colors.yellow[700]!,
    onSecondary: Colors.yellow[700]!,
    onSurface: Colors.yellow[700]!,
    onBackground: Colors.yellow[700]!,
    onError: Colors.grey,
    error: Colors.red,
    brightness: Brightness.dark,
  ),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  appBarTheme: AppBarTheme(color: Colors.white, foregroundColor: Colors.black),
  colorScheme: ColorScheme(
    primary: Colors.white,
    secondary: Colors.black,
    surface: const Color(0xFFE5E5E5),
    background: const Color(0xFFE5E5E5),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.grey,
    error: Colors.red,
    brightness: Brightness.light,
  ),
  dividerColor: Colors.white54,
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
