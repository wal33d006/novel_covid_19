import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/use_cases/get_global_info_use_case.dart';
import 'package:novel_covid_19/ui/country_details/country_details_initial_params.dart';
import 'package:novel_covid_19/domain/utils/future_either_extensions.dart';
import 'package:novel_covid_19/ui/global_info/global_info_navigator.dart';
import 'package:novel_covid_19/ui/global_info/global_info_presentation_model.dart';

class GlobalInfoPresenter {
  const GlobalInfoPresenter(
    this._model,
    this.navigator,
    this._getGlobalInfoUseCase,
  );

  final GlobalInfoPresentationModel _model;

  GlobalInfoViewModel get viewModel => _model;

  final GlobalInfoNavigator navigator;

  final GetGlobalInfoUseCase _getGlobalInfoUseCase;

  Future<void> init() async {
    _model.getGlobalInfoFuture = _getGlobalInfoUseCase.execute().observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (globalInfo) => _model.globalInfo = globalInfo,
        );
  }

  void onSelectedCountryTapped(CountryDetail selectedCountry) => navigator.openCountryDetails(
        CountryDetailsInitialParams(countryDetail: selectedCountry),
      );
}
