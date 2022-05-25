import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum GetThemeFailureType {
  Unknown,
  Storage,
}

class GetThemeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetThemeFailure.unknown([this.cause]) : type = GetThemeFailureType.Unknown;

  const GetThemeFailure.storage([this.cause]) : type = GetThemeFailureType.Storage;

  final GetThemeFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetThemeFailureType.Unknown:
      case GetThemeFailureType.Storage:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetThemeFailure{type: , cause: }';
  }
}
