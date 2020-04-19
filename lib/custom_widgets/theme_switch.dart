import 'package:flutter/material.dart';
import 'package:novel_covid_19/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  var _darkTheme = true;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferencesKeys.isDarkTheme, value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Switch(
      activeColor: Theme.of(context).accentColor,
      onChanged: (value) {
        setState(() {
          _darkTheme = value;
        });
        onThemeChanged(value, themeNotifier);
      },
      value: _darkTheme,
    );
  }
}
