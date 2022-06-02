import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/failures/get_theme_failure.dart';
import 'package:novel_covid_19/domain/stores/local_storage.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/domain/utils/dartz_extensions.dart';

class GetThemeUseCase {
  GetThemeUseCase(
    this._settingsStore,
    this._localStorage,
  );

  final SettingsStore _settingsStore;

  final LocalStorage _localStorage;

  Future<Either<GetThemeFailure, Unit>> execute() async {
    return _localStorage.readBool(SharedPreferencesKeys.isDarkTheme).asyncFold(
      (fail) => left(GetThemeFailure.storage()),
      (isDarkTheme) {
        _settingsStore.isDarkTheme = isDarkTheme;
        return right(unit);
      },
    );
  }
}
