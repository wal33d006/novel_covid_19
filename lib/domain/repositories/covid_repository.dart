import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/data/models/global_info_model.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';

abstract class CovidRepository {
  Future<Either<GetGlobalInfoFailure, GlobalInfoModel>> getGlobalInfo();

  Future<Either<GetCountryListFailure, List<CountryModel>>> getAllCountriesInfo();

  Future<CountryModel> getCountryByName(String country);
}
