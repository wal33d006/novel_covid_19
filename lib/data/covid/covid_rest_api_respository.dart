import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/data/models/global_info_model.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/data/http/http_service.dart';
import 'package:novel_covid_19/domain/repositories/covid_repository.dart';

class CovidRestApiRepository implements CovidRepository {
  final HttpService _httpService;

  const CovidRestApiRepository(this._httpService);

  @override
  Future<Either<GetGlobalInfoFailure, GlobalInfo>> getGlobalInfo() async {
    try {
      String response = await _httpService.get(UrlConstants.globalInfo);
      return right(GlobalInfoModel.fromJson(jsonDecode(response) as Map<String, dynamic>).toDomain());
    } catch (ex) {
      print(ex);
      return left(const GetGlobalInfoFailure.unknown());
    }
  }

  @override
  Future<Either<GetCountryListFailure, List<CountryDetail>>> getAllCountriesInfo() async {
    try {
      var response = await _httpService.get(UrlConstants.allCountries);
      var list = jsonDecode(response) as List;
      return right(list.map((item) => CountryModel.fromJson(item as Map<String, dynamic>).toDomain()).toList());
    } catch (ex) {
      print(ex);
      return left(const GetCountryListFailure.unknown());
    }
  }

  @override
  Future<CountryModel> getCountryByName(String country) async {
    var response = await _httpService.get('${UrlConstants.allCountries}/$country');
    return CountryModel.fromJson(jsonDecode(response));
  }
}
