import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/http/http.dart';
import 'package:tdd_clean_patterns_solid/infra/http/http_adapter.dart';

class ClientSpy extends Mock implements http.Client {}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late Uri uri;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
  });
  group("shared", () {
    test("should throw serverError if invalid method is provided", () async {
      final future = sut.request(
        url: uri.toString(),
        method: "invalid",
      );
      expect(future, throwsA(HttpError.serverError));
    });
  });
  group(
    "post",
    () {
      When mockRequest() => when(
            () => client.post(
              any(),
              body: any(named: "body"),
              headers: any(named: "headers"),
            ),
          );

      void mockError() => mockRequest().thenThrow(Exception());

      void mockResponse(int statusCode,
              {String body = '{"any_key":"any_value"}'}) =>
          mockRequest().thenAnswer(
            (_) async => http.Response(body, statusCode),
          );

      setUp(() {
        registerFallbackValue(Uri.parse(url));
        mockResponse(200);
      });
      test(
        "should call post with correct values",
        () async {
          await sut.request(
              url: uri.toString(),
              method: "post",
              body: {'any_key': 'any_value'});
          verify(
            () => client.post(
              uri,
              body: '{"any_key":"any_value"}',
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
            ),
          );
        },
      );

      test(
        "should call post without body",
        () async {
          await sut.request(url: uri.toString(), method: "post", body: null);
          verify(
            () => client.post(
              uri,
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
            ),
          );
        },
      );

      test(
        "should return null if post returns 204",
        () async {
          mockResponse(204, body: '');
          final response =
              await sut.request(url: uri.toString(), method: "post");
          verify(
            () => client.post(
              uri,
              body: null,
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
            ),
          );
          expect(response, null);
        },
      );

      test(
        "should return null if post returns 204",
        () async {
          mockResponse(204, body: '');
          final response =
              await sut.request(url: uri.toString(), method: "post");
          verify(
            () => client.post(
              uri,
              body: null,
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
            ),
          );
          expect(response, null);
        },
      );

      test(
        "should return null if post returns 204 with data",
        () async {
          mockResponse(204);
          final response =
              await sut.request(url: uri.toString(), method: "post");
          verify(
            () => client.post(
              uri,
              body: null,
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json'
              },
            ),
          );
          expect(response, null);
        },
      );

      test(
        "should return BadRequestError if post with body returns 400",
        () async {
          mockResponse(400);
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.badRequest));
        },
      );

      test(
        "should return BadRequestError if post returns 400",
        () async {
          mockResponse(400, body: '');
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.badRequest));
        },
      );

      test(
        "should return BadRequestError if post returns 500",
        () async {
          mockResponse(500);
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.serverError));
        },
      );

      test(
        "should return UnathorizedError if post returns 401",
        () async {
          mockResponse(401);
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.unathorized));
        },
      );

      test(
        "should return forbiddenError if post returns 403",
        () async {
          mockResponse(403);
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.forbidden));
        },
      );

      test(
        "should return notFoundError if post returns 404",
        () async {
          mockResponse(404);
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.notFound));
        },
      );

      test(
        "should return ServerError if post throws",
        () async {
          mockError();
          final future = sut.request(url: uri.toString(), method: "post");
          expect(future, throwsA(HttpError.serverError));
        },
      );
    },
  );
}
