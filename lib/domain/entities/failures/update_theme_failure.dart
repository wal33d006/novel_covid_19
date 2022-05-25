import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum UpdateThemeFailureType {
  Unknown,
  Storage,
}

class UpdateThemeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateThemeFailure.unknown([this.cause]) : type = UpdateThemeFailureType.Unknown;

  const UpdateThemeFailure.storage([this.cause]) : type = UpdateThemeFailureType.Storage;

  final UpdateThemeFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateThemeFailureType.Unknown:
      case UpdateThemeFailureType.Storage:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'UpdateThemeFailure{type: , cause: }';
  }
}
