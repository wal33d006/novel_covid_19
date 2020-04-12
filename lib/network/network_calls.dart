import 'dart:io';
import '../global.dart';
import 'package:http/http.dart';

class NetworkCalls {
  Future<String> get(String url) async {
    var response = await client.get(url);
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if(response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}