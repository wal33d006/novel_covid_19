import 'package:flutter/material.dart';
import 'package:novel_covid_19/custom_widgets/theme_switch.dart';
import 'package:novel_covid_19/global.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: 100,
            height: height,
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemCount: navigation.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _showNavigationRail = false;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(navigation[index]['icon']),
                      Text(navigation[index]['label']),
                    ],
                  ),
                );
              },
            ),
          ),
          AnimatedContainer(
            transform: Matrix4.identity()
              ..translate(_showNavigationRail ? 100.0 : 0.0),
            duration: Duration(milliseconds: 300),
            child: _widgets.elementAt(_currentIndex),
          ),
        ],
      ),
    );
  }
}
