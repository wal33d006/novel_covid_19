import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:novel_covid_19/data/covid/covid_rest_api_respository.dart';
import 'package:novel_covid_19/data/http/http_service.dart';
import 'package:novel_covid_19/domain/repositories/covid_repository.dart';

void main() {
  // test('Get global info', () async {
  //   CovidApi api = CovidApi();
  //   GlobalInfoModel info = await api.getGlobalInfo();
  //   print(info.cases);
  // });

  // test('Get all countries info', () async {
  //   CovidApi api = CovidApi();
  //   var list = await api.getAllCountriesInfo();
  //   print(list.first.country);
  // });

  test('Get country by name', () async {
    CovidRepository api = CovidRestApiRepository(HttpService(Client()));
    var country = await api.getCountryByName('Pakistan');
    print(country.country);
  });
}
