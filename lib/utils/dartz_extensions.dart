import 'package:dartz/dartz.dart';
extension IterableExtensions<T> on Iterable<T> {
  /// maps the passed iterable with the mapper that accepts index and element.
  Iterable<T2> mapIndexed<T2>(T2 Function(int, T) mapper) {
    return toList() //
        .asMap()
        .map((key, value) => MapEntry(key, mapper(key, value)))
        .values;
  }

  T? firstOrNull({bool Function(T)? where}) {
    try {
      return firstWhere(
            (it) => where?.call(it) ?? true,
      );
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }
}

extension AsyncEither<L, R> on Future<Either<L, R>> {
  Future<Either<L2, R>> mapError<L2>(L2 Function(L fail) errorMapper) async {
    return (await this).leftMap(errorMapper);
  }

  Future<Either<L, R2>> mapSuccess<R2>(R2 Function(R response) responseMapper) async {
    return (await this).map(responseMapper);
  }

  Future<Either<L, R>> doOn({
    void Function(L fail)? fail,
    void Function(R success)? success,
  }) async {
    try {
      (await this).fold(fail ?? (_) {}, success ?? (_) {});
      return this;
    } catch (e, stack) {
      // Log error
      rethrow;
    }
  }

  Future<R2> asyncFold<R2>(
      R2 Function(L fail) fail,
      R2 Function(R success) success,
      ) async =>
      (await this).fold(fail, success);

  Future<R> getOrThrow() async => asyncFold(
        (l) => throw l as Object,
        (r) => r,
  );
}
