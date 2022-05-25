import 'package:mobx/mobx.dart';

class SettingsStore with _SettingsStoreBase {
  bool get isDarkTheme => _isDarkTheme.value;
}

mixin _SettingsStoreBase {
  //////////////////////////////////////
  final Observable<bool> _isDarkTheme = Observable(true);

  set isDarkTheme(bool value) => Action(() => _isDarkTheme.value = value)();
}
