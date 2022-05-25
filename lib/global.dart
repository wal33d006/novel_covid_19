abstract class UrlConstants {
  static const String baseUrl = 'https://coronavirus-19-api.herokuapp.com';
  static const String globalInfo = '$baseUrl/all';
  static const String allCountries = '$baseUrl/countries';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}
