import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/failures/update_theme_failure.dart';
import 'package:novel_covid_19/domain/stores/local_store.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/utils/dartz_extensions.dart';

class UpdateThemeUseCase {
  UpdateThemeUseCase(
    this._settingsStore,
    this._localStorage,
  );

  final SettingsStore _settingsStore;

  final LocalStorage _localStorage;

  Future<Either<UpdateThemeFailure, Unit>> execute({
    required bool isDarkTheme,
  }) async {
    return _localStorage.save(SharedPreferencesKeys.isDarkTheme, isDarkTheme).asyncFold(
      (fail) => left(UpdateThemeFailure.storage()),
      (success) {
        _settingsStore.isDarkTheme = isDarkTheme;
        return right(unit);
      },
    );
  }
}
