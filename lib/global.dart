import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain/entities/home_country.dart';
import 'network/network_calls.dart';

final client = Client();

final netWorkCalls = NetworkCalls();

final mySharedPreferences = MySharedPreferences();

final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
final Function mathFunc = (Match match) => '${match[1]},';

abstract class UrlConstants {
  static const String baseUrl = 'https://coronavirus-19-api.herokuapp.com';
  static const String globalInfo = '$baseUrl/all';
  static const String allCountries = '$baseUrl/countries';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}

class MySharedPreferences {
  Future<List<String>?> fetchHomeCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(SharedPreferencesKeys.homeCountryDetails);
    if (list != null) {
      return list;
    }
    return null;
  }

  Future setHomeCountry(HomeCountry country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      SharedPreferencesKeys.homeCountryDetails,
      <String>[
        country.name!,
        country.cases!,
        country.deaths!,
      ],
    );
  }
}

List<Map<String, dynamic>> navigation = [
  {"icon": Icons.public, "label": "Global", "idx": 1},
  {"icon": Icons.list, "label": "Countries", "idx": 2},
  {"icon": Icons.info, "label": "About", "idx": 3}
];
