import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';

class AuthorizeHttpClientDecorator implements HttpClientDemo {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClientDemo decoratee;

  AuthorizeHttpClientDecorator(
      {required this.fetchSecureCacheStorage, required this.decoratee});
  Future<dynamic> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    try {
      //Base Case
      final token = await fetchSecureCacheStorage.fetchSecure("token");

      final authorizeHeaders = headers ?? {}
        ..addAll({"x-access-token": token});
      return await decoratee.request(
          url: url, method: method, body: body, headers: authorizeHeaders);
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClientDemo {}

void main() {
  late HttpClientSpy httpClient;
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late AuthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map? body;
  late String token;
  late String httpResponse;

  void mockToken() {
    token = faker.guid.guid();
    when(() => fetchSecureCacheStorage.fetchSecure(any()))
        .thenAnswer((_) async => token);
  }

  void mockTokenError() {
    token = faker.guid.guid();
    when(() => fetchSecureCacheStorage.fetchSecure(any()))
        .thenThrow(Exception());
  }

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    when(() => httpClient.request(
        url: any(named: "url"),
        method: any(named: "method"),
        body: any(named: "body"),
        headers: any(named: "headers"))).thenAnswer((_) async => httpResponse);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage: fetchSecureCacheStorage,
        decoratee: httpClient);
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': "any_value"};

    mockToken();
    mockHttpResponse();
  });

  test("should call FetchSecureCacheStorage with correct key", () async {
    await sut.request(url: url, method: method, body: body);
    verify(() => fetchSecureCacheStorage.fetchSecure("token")).called(1);
  });

  test("should call decoratee with access token on header", () async {
    await sut.request(url: url, method: method, body: body);

    verify(() => httpClient.request(
        url: url,
        method: method,
        body: body,
        headers: {"x-access-token": token})).called(1);
  });
}
