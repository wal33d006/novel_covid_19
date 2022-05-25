import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum SetSelectedCountryFailureType {
  Unknown,
}

class SetSelectedCountryFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SetSelectedCountryFailure.unknown([this.cause]) : type = SetSelectedCountryFailureType.Unknown;

  final SetSelectedCountryFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case SetSelectedCountryFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'SetSelectedCountryFailure{type: , cause: }';
  }
}
