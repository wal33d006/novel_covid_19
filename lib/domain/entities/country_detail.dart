import 'package:equatable/equatable.dart';

class CountryDetail extends Equatable {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int totalTests;
  final int testsPerOneMillion;

  const CountryDetail({
    required this.country,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.casesPerOneMillion,
    required this.deathsPerOneMillion,
    required this.totalTests,
    required this.testsPerOneMillion,
  });

  const CountryDetail.empty()
      : country = '',
        cases = 0,
        todayCases = 0,
        deaths = 0,
        todayDeaths = 0,
        recovered = 0,
        active = 0,
        critical = 0,
        casesPerOneMillion = 0,
        deathsPerOneMillion = 0,
        totalTests = 0,
        this.testsPerOneMillion = 0;

  String get recoveryPercentageString => recoveryPercentage.toStringAsFixed(2);

  double get recoveryPercentage => (recovered / cases) * 100;

  String get deathPercentageString => deathPercentage.toStringAsFixed(2);

  double get deathPercentage => (deaths / cases) * 100;

  String get activePercentageString => (100 - (deathPercentage + recoveryPercentage)).toStringAsFixed(2);

  @override
  List<Object?> get props => [country];
}
