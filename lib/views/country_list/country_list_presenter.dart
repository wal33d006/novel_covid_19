import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/use_cases/get_country_list_use_case.dart';
import 'package:novel_covid_19/utils/future_either_extensions.dart';
import 'package:novel_covid_19/views/country_details/country_details_initial_params.dart';
import 'package:novel_covid_19/views/country_list/country_list_navigator.dart';
import 'package:novel_covid_19/views/country_list/country_list_presentation_model.dart';

class CountryListPresenter {
  const CountryListPresenter(
    this._model,
    this.navigator,
    this._getCountryListUseCase,
  );

  final CountryListPresentationModel _model;

  CountryListViewModel get viewModel => _model;

  final CountryListNavigator navigator;

  final GetCountryListUseCase _getCountryListUseCase;

  void onItemTapped(CountryDetail country) => navigator.openCountryDetails(
        CountryDetailsInitialParams(countryDetail: country),
      );

  Future<void> init() async {
    _model.getCountryListFuture = _getCountryListUseCase.execute().observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (list) => _model.countries = list,
        );
  }
}
