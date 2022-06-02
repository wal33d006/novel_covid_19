import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/use_cases/set_selected_country_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/update_theme_use_case.dart';
import 'package:novel_covid_19/ui/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presentation_model.dart';

class CountryDetailsPresenter {
  CountryDetailsPresenter(
    this._model,
    this.navigator,
    this._updateThemeUseCase,
    this._selectedCountryUseCase,
  );

  CountryDetailsPresentationModel _model;
  CountryDetailsNavigator navigator;
  UpdateThemeUseCase _updateThemeUseCase;
  SetSelectedCountryUseCase _selectedCountryUseCase;

  CountryDetailsViewModel get viewModel => _model;

  void onThemeUpdated(bool value) => _updateThemeUseCase.execute(isDarkTheme: value);

  void onSetSelectedCountry(CountryDetail country) => _selectedCountryUseCase.execute(selectedCountry: country);
}
