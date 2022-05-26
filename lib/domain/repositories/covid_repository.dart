import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';

abstract class CovidRepository {
  Future<Either<GetGlobalInfoFailure, GlobalInfo>> getGlobalInfo();

  Future<Either<GetCountryListFailure, List<CountryDetail>>> getAllCountriesInfo();

  Future<CountryModel> getCountryByName(String country);
}
