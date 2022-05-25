import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

enum GetGlobalInfoFailureType {
  Unknown,
}

class GetGlobalInfoFailure {
  const GetGlobalInfoFailure.unknown({this.cause}) : _type = GetGlobalInfoFailureType.Unknown;

  final GetGlobalInfoFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case GetGlobalInfoFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetGlobalInfoFailure{cause: $cause}';
  }
}
