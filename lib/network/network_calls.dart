import 'dart:io';
import '../global.dart';
import 'package:http/http.dart';

class NetworkCalls {
  Future<String> get(String url) async {
    Uri uri = Uri.parse(url);
    var response = await client.get(uri);
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if(response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}