import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_clean_patterns_solid/data/http/http.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';

class HttpAdapter implements HttpClientDemo {
  final http.Client client;
  HttpAdapter(this.client);
  @override
  Future<Map?> request(
      {required String url, required String method, Map? body}) async {
    final urlParse = Uri.parse(url);
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    var response = http.Response('', 500);

    try {
      if (method == "post") {
        final parsedBody = body != null ? jsonEncode(body) : null;
        response =
            await client.post(urlParse, headers: headers, body: parsedBody);
      }
    } catch (e) {
      throw HttpError.serverError;
    }

    _handleResponse(response);
  }

  Map? _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
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
