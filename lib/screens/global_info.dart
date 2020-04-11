import 'package:flutter/material.dart';
import 'package:novel_covid_19/api/covid_api.dart';
import 'package:novel_covid_19/models/global_info_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class GlobalInfoPage extends StatefulWidget {
  @override
  _GlobalInfoPageState createState() => _GlobalInfoPageState();
}

class _GlobalInfoPageState extends State<GlobalInfoPage> {
  CovidApi api = CovidApi();
  GlobalInfo _stats;
  bool _isLoading = false;

  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  double deathPercentage;
  double recoveryPercentage;
  double activePercentage;

  var _darkTheme = true;

  @override
  void initState() {
    super.initState();
    _fetchGlobalStats();
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 stats',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: Icon(
          Icons.public,
          color: Theme.of(context).accentColor,
        ),
        actions: <Widget>[
          Switch(
            activeColor: Theme.of(context).accentColor,
            onChanged: (value) {
              setState(() {
                _darkTheme = value;
              });
              onThemeChanged(value, themeNotifier);
            },
            value: _darkTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: HeartbeatProgressIndicator(
                  child: SizedBox(
                      height: 50.0,
                      child: Image(
                        image: AssetImage(
                          'assets/loader.png',
                        ),
                        color: Theme.of(context).accentColor,
                      )),
                ),
              )
            : _stats == null
                ? Center(
                    child: Text(
                      'Unable to fetch data',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.grey),
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      _buildCard(
                        Colors.orange,
                        'Total cases',
                        _stats.cases,
                        Icons.timeline,
                      ),
                      _buildCard(
                        Colors.green,
                        'Total recovered',
                        _stats.recovered,
                        Icons.airline_seat_individual_suite,
                      ),
                      _buildCard(
                        Colors.red,
                        'Total deaths',
                        _stats.deaths,
                        Icons.whatshot,
                      ),
                    ],
                  ),
      ),
    );
  }

  Padding _buildCard(Color color, String text, int stats, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.blueGrey,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stats.toString().replaceAllMapped(reg, mathFunc),
                      style: Theme.of(context).textTheme.display2,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    size: 100.0,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _fetchGlobalStats() async {
    setState(() => _isLoading = true);
    try {
      var stats = await api.getGlobalInfo();
      deathPercentage = (stats.deaths / stats.cases) * 100;
      recoveryPercentage = (stats.recovered / stats.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);

      print(deathPercentage);
      print(recoveryPercentage);
      print(activePercentage);
      setState(() => _stats = stats);
    } catch (ex) {
      setState(() => _stats = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

class MyData {
  final double cases;
  final int index;

  MyData(this.cases, this.index);
}
