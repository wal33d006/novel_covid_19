import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/use_cases/get_country_list_use_case.dart';
import 'package:novel_covid_19/domain/utils/future_either_extensions.dart';
import 'package:novel_covid_19/ui/country_details/country_details_initial_params.dart';
import 'package:novel_covid_19/ui/country_list/country_list_navigator.dart';
import 'package:novel_covid_19/ui/country_list/country_list_presentation_model.dart';

class CountryListPresenter {
  const CountryListPresenter(
    this._model,
    this.navigator,
    this._getCountryListUseCase,
  );

  final CountryListPresentationModel _model;
  final CountryListNavigator navigator;
  final GetCountryListUseCase _getCountryListUseCase;

  CountryListViewModel get viewModel => _model;

  void onItemTapped(CountryDetail country) => navigator.openCountryDetails(
        CountryDetailsInitialParams(countryDetail: country),
      );

  Future<void> init() async {
    _model.getCountryListFuture = _getCountryListUseCase.execute().observableDoOn(
      (fail) => navigator.showError(fail.displayableFailure()),
      (list) {
        _model.searchItems.addAll(list);
        _model.countries.addAll(list);
      },
    );
  }

  void onSearchChanged(String query) {
    var searchItems = _model.searchItems;
    List<CountryDetail> dummySearchList = <CountryDetail>[];
    dummySearchList.addAll(_model.countries);
    if (query.isNotEmpty) {
      List<CountryDetail> dummyListData = <CountryDetail>[];
      dummySearchList.forEach((item) {
        if (item.country.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      searchItems.clear();
      searchItems.addAll(dummyListData);

      return;
    } else {
      searchItems.clear();
      searchItems.addAll(_model.countries);
    }
  }
}
