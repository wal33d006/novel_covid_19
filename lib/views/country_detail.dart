import 'package:flutter/material.dart';
import 'package:novel_covid_19/controllers/covid_api.dart';
import 'package:novel_covid_19/custom_widgets/statistic_card.dart';
import 'package:novel_covid_19/custom_widgets/theme_switch.dart';
import 'package:novel_covid_19/custom_widgets/virus_loader.dart';
import 'package:novel_covid_19/models/country_model.dart';

import '../global.dart';

class CountryDetailPage extends StatefulWidget {
  final String countryName;

  CountryDetailPage({@required this.countryName});

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Country _countryInfo;
  double deathPercentage;
  double activePercentage;
  bool _isLoading = false;
  bool _isHome = false;
  CovidApi api = CovidApi();
  double recoveryPercentage;
  bool _isSettingCountry = false;

  @override
  void initState() {
    super.initState();
    _initiateSharedPreferences();
    _fetchCountryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.countryName,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: <Widget>[
          ThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? VirusLoader()
            : _countryInfo == null
                ? buildErrorMessage()
                : ListView(
                    children: <Widget>[
                      if (!_isHome)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: _isSettingCountry
                                    ? null
                                    : () async {
                                        setState(() {
                                          _isSettingCountry = true;
                                        });
                                        await mySharedPreferences
                                            .setHomeCountry(HomeCountry(
                                          name: _countryInfo.country,
                                          cases: _countryInfo.cases.toString(),
                                          deaths:
                                              _countryInfo.deaths.toString(),
                                        ));
                                        setState(() {
                                          _isHome = true;
                                          _isSettingCountry = false;
                                        });
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  margin: const EdgeInsets.all(16.0),
                                  child: Text(
                                    _isSettingCountry
                                        ? '...'
                                        : 'Set as Home country',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      StatisticCard(
                        color: Colors.orange,
                        text: 'Total cases',
                        icon: Icons.timeline,
                        stats: _countryInfo.cases,
                      ),
                      StatisticCard(
                        color: Colors.green,
                        text: 'Total recovered',
                        icon: Icons.verified_user,
                        stats: _countryInfo.recovered,
                      ),
                      StatisticCard(
                        color: Colors.blue,
                        text: 'Active cases',
                        icon: Icons.whatshot,
                        stats: _countryInfo.active,
                      ),
                      StatisticCard(
                        color: Colors.black,
                        text: 'Critical cases',
                        icon: Icons.battery_alert,
                        stats: _countryInfo.critical,
                      ),
                      StatisticCard(
                        color: Colors.blueGrey,
                        text: 'Total tests',
                        icon: Icons.youtube_searched_for,
                        stats: _countryInfo.totalTests,
                      ),
                      StatisticCard(
                        color: Colors.red,
                        text: 'Total deaths',
                        icon: Icons.airline_seat_individual_suite,
                        stats: _countryInfo.deaths,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Icon(Icons.sentiment_very_dissatisfied),
                            title: Text('Death percentage'),
                            trailing: Text(
                              deathPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            leading: Icon(Icons.sentiment_very_satisfied),
                            title: Text('Recovery percentage'),
                            trailing: Text(
                              recoveryPercentage.toStringAsFixed(2) + ' %',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to fetch data',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
      ),
    );
  }

  void _fetchCountryDetails() async {
    setState(() => _isLoading = true);
    try {
      var countryInfo = await api.getCountryByName(widget.countryName);
      deathPercentage = (countryInfo.deaths / countryInfo.cases) * 100;
      recoveryPercentage = (countryInfo.recovered / countryInfo.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);

      print(deathPercentage);
      print(recoveryPercentage);
      print(activePercentage);
      setState(() => _countryInfo = countryInfo);
    } catch (ex) {
      setState(() => _countryInfo = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _initiateSharedPreferences() async {
    var list = await mySharedPreferences.fetchHomeCountry();
    if (list != null && list[0].compareTo(widget.countryName) == 0)
      setState(() {
        _isHome = true;
      });
  }
}
