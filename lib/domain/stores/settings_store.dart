import 'package:mobx/mobx.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';

class SettingsStore with _SettingsStoreBase {
  bool get isDarkTheme => _isDarkTheme.value;

  CountryDetail get selectedCountry => _selectedCountry.value;
}

mixin _SettingsStoreBase {
  //////////////////////////////////////
  final Observable<bool> _isDarkTheme = Observable(true);

  set isDarkTheme(bool value) => Action(() => _isDarkTheme.value = value)();

  //////////////////////////////////////
  final Observable<CountryDetail> _selectedCountry = Observable(const CountryDetail.empty());

  set selectedCountry(CountryDetail value) => Action(() => _selectedCountry.value = value)();
}
