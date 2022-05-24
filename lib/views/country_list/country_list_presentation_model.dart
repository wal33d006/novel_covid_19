import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_country_list_failure.dart';
import 'package:novel_covid_19/utils/future_either_extensions.dart';
import 'package:novel_covid_19/views/country_list/country_list_initial_params.dart';

abstract class CountryListViewModel {
  List<CountryDetail> get countries;

  bool get isLoading;
}

class CountryListPresentationModel with CountryListPresentationModelBase implements CountryListViewModel {
  CountryListPresentationModel(this.initialParams);

  final CountryListInitialParams initialParams;

  @override
  List<CountryDetail> get countries => _countries.value;

  ObservableFuture<Either<GetCountryListFailure, List<CountryDetail>>>? get getCountryListFuture =>
      _getCountryListFuture.value;

  @override
  bool get isLoading => isFutureInProgress(getCountryListFuture);
}

abstract class CountryListPresentationModelBase {
  final Observable<List<CountryDetail>> _countries = Observable(ObservableList());

  set countries(List<CountryDetail> value) => Action(() => _countries.value = value)();

  final Observable<ObservableFuture<Either<GetCountryListFailure, List<CountryDetail>>>?> _getCountryListFuture =
      Observable(null);

  set getCountryListFuture(ObservableFuture<Either<GetCountryListFailure, List<CountryDetail>>>? value) =>
      Action(() => _getCountryListFuture.value = value)();
}
