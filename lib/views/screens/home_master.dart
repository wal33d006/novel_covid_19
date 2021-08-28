import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/views/widgets/top_navbar.dart';
import 'personal_info.dart';
import 'country_list.dart';
import 'global_info.dart';

class HomePageMaster extends StatefulWidget {
  @override
  _HomePageMasterState createState() => _HomePageMasterState();
}

class _HomePageMasterState extends State<HomePageMaster> {
  String _currentAppBarTitle = 'Global';
  int _currentIndex = 0;
  bool _showNavigationRail = false;

  List<Widget> _widgets = <Widget>[
    GlobalInfoPage(),
    CountryListPage(),
    PersonalInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    void setAppBarLabelName(index) {
      if (index == 0) {
        _currentAppBarTitle = 'Global';
      } else if (index == 1) {
        _currentAppBarTitle = 'Countries';
      } else {
        _currentAppBarTitle = 'About';
      }
    }

    return Scaffold(
      appBar: TopAppBar().buildAppBar(
        currentAppBarTitle: _currentAppBarTitle,
        color: Theme.of(context).accentColor,
        onPress: () {
          setState(() {
            _showNavigationRail = !_showNavigationRail;
          });
        },
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 18.0),
            width: 85,
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemCount: navigation.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _showNavigationRail = false;

                      setAppBarLabelName(index);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      children: [
                        Icon(navigation[index]['icon']),
                        SizedBox(height: 5.0),
                        Text(navigation[index]['label']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedContainer(
            width: _showNavigationRail ? width - 85.0 : width,
            transform: Matrix4.identity()
              ..translate(_showNavigationRail ? 85.0 : 0.0),
            duration: Duration(milliseconds: 300),
            child: _widgets.elementAt(_currentIndex),
          ),
        ],
      ),
    );
  }
}