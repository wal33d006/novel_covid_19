import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/views/country_details/country_details_initial_params.dart';

abstract class CountryDetailsViewModel {
  CountryDetail get countryDetail;

  bool get isHomeCountry;
}

class CountryDetailsPresentationModel with CountryDetailsPresentationModelBase implements CountryDetailsViewModel {
  CountryDetailsPresentationModel(this.initialParams);

  final CountryDetailsInitialParams initialParams;

  @override
  CountryDetail get countryDetail => initialParams.countryDetail;

  @override
  // TODO: implement isHomeCountry
  bool get isHomeCountry => throw UnimplementedError();
}

abstract class CountryDetailsPresentationModelBase {}
