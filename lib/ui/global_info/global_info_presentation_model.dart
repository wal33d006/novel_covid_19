import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';
import 'package:novel_covid_19/utils/future_either_extensions.dart';
import 'package:novel_covid_19/ui/global_info/global_info_initial_params.dart';

abstract class GlobalInfoViewModel {
  GlobalInfo get globalInfo;

  bool get isLoading;
}

class GlobalInfoPresentationModel with GlobalInfoPresentationModelBase implements GlobalInfoViewModel {
  GlobalInfoPresentationModel(this.initialParams);

  final GlobalInfoInitialParams initialParams;

  @override
  GlobalInfo get globalInfo => _globalInfo.value;

  ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>? get getGlobalInfoFuture => _getGlobalInfoFuture.value;

  @override
  bool get isLoading => isFutureInProgress(getGlobalInfoFuture);
}

abstract class GlobalInfoPresentationModelBase {
  final Observable<GlobalInfo> _globalInfo = Observable(const GlobalInfo.empty());

  set globalInfo(GlobalInfo value) => Action(() => _globalInfo.value = value)();

  final Observable<ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>?> _getGlobalInfoFuture = Observable(null);

  set getGlobalInfoFuture(ObservableFuture<Either<GetGlobalInfoFailure, GlobalInfo>>? value) =>
      Action(() => _getGlobalInfoFuture.value = value)();
}
