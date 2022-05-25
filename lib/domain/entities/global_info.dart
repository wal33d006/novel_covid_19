import 'package:equatable/equatable.dart';

class GlobalInfo extends Equatable {
  final int cases;
  final int deaths;
  final int recovered;

  const GlobalInfo({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  const GlobalInfo.empty()
      : cases = 0,
        deaths = 0,
        recovered = 0;

  String get recoveryPercentageString => recoveryPercentage.toStringAsFixed(2);

  double get recoveryPercentage => (recovered / cases) * 100;

  String get deathPercentageString => deathPercentage.toStringAsFixed(2);

  double get deathPercentage => (deaths / cases) * 100;

  String get activePercentageString => (100 - (deathPercentage + recoveryPercentage)).toStringAsFixed(2);

  @override
  List<Object?> get props => [cases, deaths, recovered];
}
