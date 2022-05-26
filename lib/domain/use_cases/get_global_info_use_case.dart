import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/failures/get_global_info_failure.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';
import 'package:novel_covid_19/domain/repositories/covid_repository.dart';

class GetGlobalInfoUseCase {
  GetGlobalInfoUseCase(
    this._covidApi,
  );

  final CovidRepository _covidApi;

  Future<Either<GetGlobalInfoFailure, GlobalInfo>> execute() => _covidApi.getGlobalInfo();
}
