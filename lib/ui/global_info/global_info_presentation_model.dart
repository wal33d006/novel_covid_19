import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/utils/future_either_extensions.dart';
import 'package:novel_covid_19/ui/global_info/global_info_initial_params.dart';

abstract class GlobalInfoViewModel {
  GlobalInfo get globalInfo;

  bool get isLoading;

  CountryDetail get selectedCountry;
}

class GlobalInfoPresentationModel with GlobalInfoPresentationModelBase implements GlobalInfoViewModel {
  GlobalInfoPresentationModel(this.initialParams, this._settingsStore);

  final GlobalInfoInitialParams initialParams;
  final SettingsStore _settingsStore;

  @override
  GlobalInfo get globalInfo => _globalInfo.value;

  ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>? get getGlobalInfoFuture => _getGlobalInfoFuture.value;

  @override
  bool get isLoading => isFutureInProgress(getGlobalInfoFuture);

  @override
  CountryDetail get selectedCountry => _settingsStore.selectedCountry;
}

abstract class GlobalInfoPresentationModelBase {
  //////////////////////////////////////////////////////////////
  final Observable<GlobalInfo> _globalInfo = Observable(const GlobalInfo.empty());

  set globalInfo(GlobalInfo value) => Action(() => _globalInfo.value = value)();

  //////////////////////////////////////////////////////////////
  final Observable<ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>?> _getGlobalInfoFuture = Observable(null);

  set getGlobalInfoFuture(ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>? value) =>
      Action(() => _getGlobalInfoFuture.value = value)();
}
