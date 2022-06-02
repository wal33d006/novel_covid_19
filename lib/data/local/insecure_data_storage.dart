import 'package:dartz/dartz.dart';
import 'package:novel_covid_19/domain/entities/failures/local_storage_failure.dart';
import 'package:novel_covid_19/domain/stores/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SharedPrefsProvider = Future<SharedPreferences> Function();

class InsecureDataStorage implements LocalStorage {
  InsecureDataStorage({SharedPrefsProvider? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SharedPreferences.getInstance;

  final SharedPrefsProvider _sharedPreferences;

  @override
  Future<Either<LocalStorageFailure, Unit>> save<T>(String key, T data) async {
    try {
      final prefs = await _sharedPreferences();
      switch (T) {
        case bool:
          await prefs.setBool(key, data as bool);
          return right(unit);
        case int:
          await prefs.setInt(key, data as int);
          return right(unit);
        case double:
          await prefs.setDouble(key, data as double);
          return right(unit);
        case String:
          await prefs.setString(key, data as String);
          return right(unit);
        default:
          return left(LocalStorageFailure.saveError('Not a supported data type'));
      }
    } catch (ex) {
      return left(LocalStorageFailure.saveError(ex));
    }
  }

  @override
  Future<Either<LocalStorageFailure, bool>> readBool(String key) async {
    try {
      final prefs = await _sharedPreferences();
      final response = prefs.getBool(key);
      if (response != null) {
        return right(response);
      }
      return left(LocalStorageFailure.readError('Could not read from Insecure data store'));
    } catch (ex) {
      return left(LocalStorageFailure.readError(ex));
    }
  }

  @override
  Future<Either<LocalStorageFailure, double>> readDouble(String key) async {
    try {
      final prefs = await _sharedPreferences();
      final response = prefs.getDouble(key);
      if (response != null) {
        return right(response);
      }
      return left(LocalStorageFailure.readError('Could not read from Insecure data store'));
    } catch (ex) {
      return left(LocalStorageFailure.readError(ex));
    }
  }

  @override
  Future<Either<LocalStorageFailure, int>> readInt(String key) async {
    try {
      final prefs = await _sharedPreferences();
      final response = prefs.getInt(key);
      if (response != null) {
        return right(response);
      }
      return left(LocalStorageFailure.readError('Could not read from Insecure data store'));
    } catch (ex) {
      return left(LocalStorageFailure.readError(ex));
    }
  }

  @override
  Future<Either<LocalStorageFailure, String>> readString(String key) async {
    try {
      final prefs = await _sharedPreferences();
      final response = prefs.getString(key);
      if (response != null) {
        return right(response);
      }
      return left(LocalStorageFailure.readError('Could not read from Insecure data store'));
    } catch (ex) {
      return left(LocalStorageFailure.readError(ex));
    }
  }
}
