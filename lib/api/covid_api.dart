import 'dart:convert';

import 'package:novel_covid_19/models/country_model.dart';
import 'package:novel_covid_19/models/global_info_model.dart';

import '../global.dart';

class CovidApi {
  Future<GlobalInfo> getGlobalInfo() async {
    var response =
    await client.get('https://coronavirus-19-api.herokuapp.com/all');
    return GlobalInfo.fromJson(jsonDecode(response.body));
  }

  Future<List<Country>> getAllCountriesInfo() async {
    var response =
    await client.get('https://coronavirus-19-api.herokuapp.com/countries');
    var list = jsonDecode(response.body) as List;
    return list.map((item) => Country.fromJson(item)).toList();
  }

  Future<Country> getCountryByName(String country) async {
    var response =
    await client.get('https://coronavirus-19-api.herokuapp.com/countries/$country');
    return Country.fromJson(jsonDecode(response.body));
  }
}