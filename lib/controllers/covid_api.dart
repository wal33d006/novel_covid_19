import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/data/models/global_info_model.dart';
import '../global.dart';

class CovidApi {
  Future<GlobalInfo> getGlobalInfo() async {
    String response = await netWorkCalls.get(UrlConstants.globalInfo);
    return GlobalInfo.fromJson(jsonDecode(response));
  }

  Future<Either<GetCountryListFailure, List<CountryModel>>> getAllCountriesInfo() async {
    try {
      var response = await netWorkCalls.get(UrlConstants.allCountries);
      var list = jsonDecode(response) as List;
      return right(list.map((item) => CountryModel.fromJson(item as Map<String, dynamic>)).toList());
    } catch (ex) {
      print(ex);
      return left(const GetCountryListFailure.unknown());
    }
  }

  Future<CountryModel> getCountryByName(String country) async {
    var response = await netWorkCalls.get('${UrlConstants.allCountries}/$country');
    return CountryModel.fromJson(jsonDecode(response));
  }
}
