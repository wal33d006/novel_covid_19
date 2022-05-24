import 'package:novel_covid_19/controllers/covid_api.dart';
import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/utils/future_either_extensions.dart';

class GetCountryListUseCase {
  GetCountryListUseCase(
    this._covidApi,
  );

  final CovidApi _covidApi;

  Future<Either<GetCountryListFailure, List<CountryDetail>>> execute() =>
      _covidApi.getAllCountriesInfo().flatMap((list) async => right(list.map((e) => e.toDomain()).toList()));
}
