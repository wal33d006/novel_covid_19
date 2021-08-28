import 'package:flutter/material.dart';
import 'package:novel_covid_19/views/widgets/theme_switch.dart';

class TopAppBar {
  PreferredSizeWidget? buildAppBar({onPress, currentAppBarTitle, color}) {
    return AppBar(
      title: Text(
        currentAppBarTitle,
        style: TextStyle(color: color),
      ),
      leading: IconButton(
        icon: Icon(Icons.wb_incandescent),
        color: color,
        onPressed: onPress!,
      ),
      actions: [
        ThemeSwitch(),
      ],
    );
  }
}
