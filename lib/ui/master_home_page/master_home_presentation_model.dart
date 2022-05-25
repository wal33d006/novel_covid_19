import 'package:mobx/mobx.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_initial_params.dart';

abstract class MasterHomeViewModel {
  bool get isDarkTheme;

  bool get showNavigationRail;

  String get appBarTitle;

  int get currentIndex;
}

class MasterHomePresentationModel with MasterHomePresentationModelBase implements MasterHomeViewModel {
  MasterHomePresentationModel(this.initialParams, this._settingsStore);

  final MasterHomeInitialParams initialParams;
  final SettingsStore _settingsStore;

  @override
  bool get isDarkTheme => _settingsStore.isDarkTheme;

  @override
  String get appBarTitle => _appBarTitle.value;

  @override
  bool get showNavigationRail => _showNavigationRail.value;

  @override
  int get currentIndex => _currentIndex.value;
}

abstract class MasterHomePresentationModelBase {
  //////////////////////////////////////////////////////////////
  final Observable<String> _appBarTitle = Observable('Global');

  set appBarTitle(String value) => Action(() => _appBarTitle.value = value)();

  //////////////////////////////////////////////////////////////
  final Observable<bool> _showNavigationRail = Observable(false);

  set showNavigationRail(bool value) => Action(() => _showNavigationRail.value = value)();

  //////////////////////////////////////////////////////////////
  final Observable<int> _currentIndex = Observable(0);

  set currentIndex(int value) => Action(() => _currentIndex.value = value)();
}
