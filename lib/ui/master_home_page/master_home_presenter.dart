import 'package:novel_covid_19/domain/use_cases/get_theme_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/update_theme_use_case.dart';
import 'package:novel_covid_19/ui/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presentation_model.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_navigator.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_presentation_model.dart';

class MasterHomePresenter {
  MasterHomePresenter(
    this._model,
    this.navigator,
    this._getThemeUseCase,
    this._updateThemeUseCase,
  );

  MasterHomePresentationModel _model;
  MasterHomeNavigator navigator;
  GetThemeUseCase _getThemeUseCase;
  UpdateThemeUseCase _updateThemeUseCase;

  MasterHomeViewModel get viewModel => _model;

  void init() => _getThemeUseCase.execute();

  void onThemeChanged(bool value) => _updateThemeUseCase.execute(isDarkTheme: value);

  void onBulbPressed() => _model.showNavigationRail = !_model.showNavigationRail;

  void onNavigationUpdated(int value) => _model.currentIndex = value;
}
