import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/set_selected_country_failure.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';

class SetSelectedCountryUseCase {
  SetSelectedCountryUseCase(
    this._settingsStore,
  );

  final SettingsStore _settingsStore;

  Future<Either<SetSelectedCountryFailure, Unit>> execute({
    required CountryDetail selectedCountry,
  }) async {
    _settingsStore.selectedCountry = selectedCountry;
    return right(unit);
  }
}
