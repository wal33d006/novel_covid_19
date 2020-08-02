import 'package:flutter/material.dart';
import 'package:novel_covid_19/custom_widgets/theme_switch.dart';
import 'package:novel_covid_19/views/personal_info.dart';
import 'country_list.dart';
import 'global_info.dart';

class HomePageMaster extends StatefulWidget {
  @override
  _HomePageMasterState createState() => _HomePageMasterState();
}

class _HomePageMasterState extends State<HomePageMaster> {
  String _currentAppBarTitle = 'Global';
  int _currentIndex = 0;

  List<Widget> _widgets = <Widget>[
    GlobalInfoPage(),
    CountryListPage(),
    PersonalInfoScreen(),
  ];

  bool _showNavigationRail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentAppBarTitle,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.wb_incandescent),
          color: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              _showNavigationRail = !_showNavigationRail;
            });
          },
        ),
        actions: <Widget>[
          ThemeSwitch(),
        ],
      ),
      body: Row(
        children: [
          AnimatedCrossFade(
            crossFadeState: _showNavigationRail
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
            firstChild: Container(),
            secondChild: NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                _currentIndex = index;
                switch (index) {
                  case 0:
                    _currentAppBarTitle = 'Global';
                    break;
                  case 1:
                    _currentAppBarTitle = 'Countries';
                    break;
                  case 2:
                    _currentAppBarTitle = 'About';
                    break;
                }
                setState(() {});
              },
              labelType: NavigationRailLabelType.selected,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.public),
                  selectedIcon: Icon(
                    Icons.public,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    'Global',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.list),
                  selectedIcon: Icon(
                    Icons.list,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    'Countries',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info),
                  selectedIcon: Icon(
                    Icons.info,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    'About',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _widgets.elementAt(_currentIndex)),
        ],
      ),
    );
  }
}
