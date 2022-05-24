import 'package:novel_covid_19/views/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/views/country_details/country_details_presentation_model.dart';

class CountryDetailsPresenter {
  CountryDetailsPresenter(this._model, this.navigator);

  CountryDetailsPresentationModel _model;
  CountryDetailsViewModel get viewModel => _model;
  CountryDetailsNavigator navigator;


}
