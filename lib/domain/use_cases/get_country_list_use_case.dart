import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/domain/repositories/covid_repository.dart';

class GetCountryListUseCase {
  GetCountryListUseCase(
    this._covidApi,
  );

  final CovidRepository _covidApi;

  Future<Either<GetCountryListFailure, List<CountryDetail>>> execute() => _covidApi.getAllCountriesInfo();
}
