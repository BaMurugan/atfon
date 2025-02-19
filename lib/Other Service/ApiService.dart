import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ApiPath.dart';

class ApiService {
  static Future<Map> call({
    required ApiCallMethod apiCallMethod,
    required String path,
    Map? body,
    String? token,
  }) async {
    late http.Response response;

    var headers = {"Content-Type": "application/json"};

    if (token != null && token != '') {
      headers['Authorization'] = token;
    }

    if (apiCallMethod == ApiCallMethod.get) {
      response = await http.get(
        Uri.parse('${ApiPaths.devServerAddress}$path'),
        headers: headers,
      );
    }

    if (apiCallMethod == ApiCallMethod.post) {
      response = await http.post(
        Uri.parse('${ApiPaths.devServerAddress}$path'),
        headers: headers,
        body: jsonEncode(body),
      );
    }

    if (apiCallMethod == ApiCallMethod.put) {
      response = await http.put(
        Uri.parse('${ApiPaths.devServerAddress}$path'),
        headers: headers,
        body: jsonEncode(body),
      );
    }

    if (apiCallMethod == ApiCallMethod.delete) {
      response = await http.delete(
        Uri.parse('${ApiPaths.devServerAddress}$path'),
        headers: headers,
      );
    }

    var responseBody = jsonDecode(response.body) as Map;

    if (response.statusCode > 299 || response.statusCode < 200) {
      return Future.error(responseBody["message"]);
    }

    return responseBody;
  }
}

enum ApiCallMethod {
  get,
  post,
  put,
  delete,
}
