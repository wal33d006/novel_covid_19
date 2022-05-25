import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum LocalStorageFailureType {
  Unknown,
  SaveError,
  ReadError,
}

class LocalStorageFailure {
  const LocalStorageFailure.unknown([this.cause]) : type = LocalStorageFailureType.Unknown;

  const LocalStorageFailure.saveError(this.cause) : type = LocalStorageFailureType.SaveError;

  const LocalStorageFailure.readError(this.cause) : type = LocalStorageFailureType.ReadError;
  final LocalStorageFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case LocalStorageFailureType.Unknown:
      case LocalStorageFailureType.SaveError:
      case LocalStorageFailureType.ReadError:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'LocalStorageFailure{$type: $cause}';
  }
}
