import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_patterns_solid/data/http/http.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';

class HttpAdapter implements HttpClientDemo {
  final http.Client client;
  HttpAdapter(this.client);
  @override
  Future<dynamic> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    final urlParse = Uri.parse(url);
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    var response = http.Response('', 500);

    try {
      final parsedBody = body != null ? jsonEncode(body) : null;
      if (method == "post") {
        response = await client
            .post(urlParse, headers: defaultHeaders, body: parsedBody)
            .timeout(Duration(seconds: 5));
      } else if (method == "get") {
        response = await client
            .get(urlParse, headers: defaultHeaders)
            .timeout(Duration(seconds: 5));
      } else if (method == "put") {
        response = await client
            .put(urlParse, headers: defaultHeaders, body: parsedBody)
            .timeout(Duration(seconds: 5));
      }
    } catch (e) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      throw HttpError.invalidData;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unathorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
