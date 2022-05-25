import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum GetCountryListFailureType {
  Unknown,
}

class GetCountryListFailure {
  const GetCountryListFailure.unknown({this.cause}) : _type = GetCountryListFailureType.Unknown;

  final GetCountryListFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case GetCountryListFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetCountryListFailure{cause: $cause}';
  }
}
