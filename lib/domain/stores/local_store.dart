import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/failures/local_storage_failure.dart';

abstract class LocalStorage {
  Future<Either<LocalStorageFailure, Unit>> save<T>(String key, T data);

  Future<Either<LocalStorageFailure, bool>> readBool(String key);

  Future<Either<LocalStorageFailure, double>> readDouble(String key);

  Future<Either<LocalStorageFailure, int>> readInt(String key);

  Future<Either<LocalStorageFailure, String>> readString(String key);
}
