import 'package:novel_covid_19/base/base_states.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/data/models/global_info_model.dart';

abstract class GlobalInfoState extends BaseState {}

class GlobalInfoLoadingState extends GlobalInfoState {
  @override
  List<Object?> get props => [];
}

class GlobalInfoLoadedState extends GlobalInfoState {
  final GlobalInfoPercentageModel? stats;
  final GlobalInfo? info;
  final HomeCountry? homeCountry;

  GlobalInfoLoadedState({this.stats, this.homeCountry, this.info});

  @override
  List<Object?> get props => [stats, info, homeCountry];
}
