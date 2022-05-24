import 'package:novel_covid_19/domain/entities/country_detail.dart';

class CountryModel {
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

  CountryModel({
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

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        country: json['country'] as String? ?? '',
        cases: json['cases'] as int? ?? 0,
        todayCases: json['todayCases'] as int? ?? 0,
        deaths: json['deaths'] as int? ?? 0,
        todayDeaths: json['todayDeaths'] as int? ?? 0,
        recovered: json['recovered'] as int? ?? 0,
        active: json['active'] as int? ?? 0,
        critical: json['critical'] as int? ?? 0,
        casesPerOneMillion: json['casesPerOneMillion'] as int? ?? 0,
        deathsPerOneMillion: json['deathsPerOneMillion'] as int? ?? 0,
        totalTests: json['totalTests'] as int? ?? 0,
        testsPerOneMillion: json['testsPerOneMillion'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['totalTests'] = this.totalTests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    return data;
  }

  CountryDetail toDomain() => CountryDetail(
        country: country,
        cases: cases,
        todayCases: todayCases,
        deaths: deaths,
        todayDeaths: todayDeaths,
        recovered: recovered,
        active: active,
        critical: critical,
        casesPerOneMillion: casesPerOneMillion,
        deathsPerOneMillion: deathsPerOneMillion,
        totalTests: totalTests,
        testsPerOneMillion: testsPerOneMillion,
      );
}

class HomeCountry {
  final String name;
  final String cases;
  final String deaths;

  HomeCountry({
    required this.name,
    required this.cases,
    required this.deaths,
  });
}
