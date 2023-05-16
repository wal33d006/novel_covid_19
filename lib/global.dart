abstract class UrlConstants {
  static const String baseUrl = 'https://disease.sh/v3/covid-19';
  static const String globalInfo = '$baseUrl/all';
  static const String allCountries = '$baseUrl/countries';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}
