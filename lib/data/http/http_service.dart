import 'dart:io';
import 'package:http/http.dart';

class HttpService {
  final Client _client;

  const HttpService(this._client);

  Future<String> get(String url) async {
    Uri uri = Uri.parse(url);
    var response = await _client.get(uri);
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}
