import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/http/http.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/add_account/remote_add_account.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/authentication/remote_authentication.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/add_account/add_account.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/authentication/authentication.dart';

class HttpClientDemoSpy extends Mock implements HttpClientDemo<Map?> {}

void main() {
  late RemoteAddAccount sut;
  late String url;
  late HttpClientDemoSpy httpClient;
  late AddAccountParams params;
  Map mockValidData() =>
      {"accessToken": faker.guid.guid(), "name": faker.person.name()};
  When _mockRequest() => when(() => httpClient.request(
        url: any(named: "url"),
        method: any(named: "method"),
        body: any(named: "body"),
      ));
  void mockHttpData(Map data) {
    _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    _mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientDemoSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    params = AddAccountParams(
        email: faker.internet.email(),
        name: faker.person.name(), 
        password: faker.internet.password(),
        passwordConfirmation: faker.internet.password(),
        );
    mockHttpData(mockValidData());
  });


  test("should call httpClient with correct params", () async {
    await sut.add(params);
    verify(() => httpClient.request(
        url: url,
        method: "post",
        body: {"email": params.email, "password": params.password, "password_confirmation": params.passwordConfirmation, "name": params.name},),);
  });

    test("should throw unexpectedError if httpclient returns 400", () async {
    mockHttpError(HttpError.badRequest);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });
 test("should throw unexpectedError if httpclient returns 404", () async {
    mockHttpError(HttpError.notFound);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

    test("should throw unexpectedError if httpclient returns 500", () async {
    mockHttpError(HttpError.serverError);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });


    test("should throw InvalidCredentialError if httpclient returns 403",
      () async {
    mockHttpError(HttpError.unathorized);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.emailInUse));
  });
}
