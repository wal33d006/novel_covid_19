import 'package:flutter/material.dart';
import 'package:novel_covid_19/ui/custom_widgets/statistic_card.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presentation_model.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presenter.dart';

class CountryDetailsPage extends StatefulWidget {
  final CountryDetailsPresenter presenter;

  const CountryDetailsPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _CountryDetailsPageState createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  CountryDetailsPresenter get presenter => widget.presenter;

  CountryDetailsViewModel get model => presenter.viewModel;

  CountryDetail get country => model.countryDetail;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          country.country,
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
          Switch(
            onChanged: presenter.onThemeChanged,
            activeColor: Theme.of(context).accentColor,
            value: model.isDarkTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            StatisticCard(
              color: Colors.orange,
              text: 'Total cases',
              icon: Icons.timeline,
              stats: country.cases,
            ),
            StatisticCard(
              color: Colors.green,
              text: 'Total recovered',
              icon: Icons.verified_user,
              stats: country.recovered,
            ),
            StatisticCard(
              color: Colors.blue,
              text: 'Active cases',
              icon: Icons.whatshot,
              stats: country.active,
            ),
            StatisticCard(
              color: Colors.black,
              text: 'Critical cases',
              icon: Icons.battery_alert,
              stats: country.critical,
            ),
            StatisticCard(
              color: Colors.blueGrey,
              text: 'Total tests',
              icon: Icons.youtube_searched_for,
              stats: country.totalTests,
            ),
            StatisticCard(
              color: Colors.red,
              text: 'Total deaths',
              icon: Icons.airline_seat_individual_suite,
              stats: country.deaths,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(Icons.sentiment_very_dissatisfied),
                  title: Text('Death percentage'),
                  trailing: Text(
                    country.deathPercentageString + ' %',
                    style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
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
                    country.recoveryPercentageString + ' %',
                    style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
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
        style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.grey),
      ),
    );
  }
}
