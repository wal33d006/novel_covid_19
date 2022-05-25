import 'package:novel_covid_19/domain/use_cases/update_theme_use_case.dart';
import 'package:novel_covid_19/ui/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presentation_model.dart';

class CountryDetailsPresenter {
  CountryDetailsPresenter(
    this._model,
    this.navigator,
    this._updateThemeUseCase,
  );

  CountryDetailsPresentationModel _model;
  CountryDetailsNavigator navigator;
  UpdateThemeUseCase _updateThemeUseCase;

  CountryDetailsViewModel get viewModel => _model;

  void onThemeChanged(bool value) {
    _updateThemeUseCase.execute(isDarkTheme: value);
  }
}
