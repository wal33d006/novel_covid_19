import 'package:novel_covid_19/domain/entities/global_info.dart';

class GlobalInfoModel {
  final int cases;
  final int deaths;
  final int recovered;

  GlobalInfoModel({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  factory GlobalInfoModel.fromJson(Map<String, dynamic> json) => GlobalInfoModel(
        cases: json['cases'] as int? ?? 0,
        deaths: json['deaths'] as int? ?? 0,
        recovered: json['recovered'] as int? ?? 0,
      );

  GlobalInfo toDomain() => GlobalInfo(
        cases: cases,
        deaths: deaths,
        recovered: recovered,
      );
}
