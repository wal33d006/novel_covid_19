import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Observer(
            builder: (context) {
              return Switch(
                value: model.isDarkTheme,
                onChanged: presenter.onThemeUpdated,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          return ListView(
            children: <Widget>[
              if (model.countryDetail != model.selectedCountry)
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => presenter.onSetSelectedCountry(country),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          margin: const EdgeInsets.all(16.0),
                          child: Text(
                            'Set as Home country',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
          );
        }),
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
