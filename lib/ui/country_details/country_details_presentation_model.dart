import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/ui/country_details/country_details_initial_params.dart';

abstract class CountryDetailsViewModel {
  CountryDetail get countryDetail;

  CountryDetail get selectedCountry;

  bool get isDarkTheme;
}

class CountryDetailsPresentationModel with CountryDetailsPresentationModelBase implements CountryDetailsViewModel {
  CountryDetailsPresentationModel(this.initialParams, this._settingsStore);

  final CountryDetailsInitialParams initialParams;
  final SettingsStore _settingsStore;

  @override
  CountryDetail get countryDetail => initialParams.countryDetail;

  @override
  CountryDetail get selectedCountry => _settingsStore.selectedCountry;

  @override
  bool get isDarkTheme => _settingsStore.isDarkTheme;
}

abstract class CountryDetailsPresentationModelBase {}
