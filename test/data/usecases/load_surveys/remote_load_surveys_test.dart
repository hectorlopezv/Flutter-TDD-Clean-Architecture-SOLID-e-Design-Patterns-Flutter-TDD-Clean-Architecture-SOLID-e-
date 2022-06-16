import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/data/models/remote_survey_model.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';



class HttpClientSpy extends Mock implements HttpClientDemo<List<Map>> {}

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadSurveys sut;
  late List<Map> list;

  List<Map> mockValidData() => [
        {
          "id": faker.guid.guid(),
          "question": faker.lorem.sentence(),
          "dateTime": faker.date.dateTime().toIso8601String(),
          "didAnswer": faker.randomGenerator.boolean(),
        },
        {
          "id": faker.guid.guid(),
          "question": faker.lorem.sentence(),
          "dateTime": faker.date.dateTime().toIso8601String(),
          "didAnswer": faker.randomGenerator.boolean(),
        },
      ];

  When mockRequest() => when(() => httpClient.request(
        url: any(named: "url"),
        method: any(named: "method"),
      ));
  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadSurveys(url: url, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test("should call HttpClient with correct values", () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: "get")).called(1);
  });

  test("should return surverys on 200", () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveryEntity(
          id: list[0]["id"],
          question: list[0]["question"],
          dateTime: DateTime.parse(list[0]["dateTime"]),
          didAnswer: list[0]["didAnswer"]),
      SurveryEntity(
          id: list[1]["id"],
          question: list[1]["question"],
          dateTime: DateTime.parse(list[1]["dateTime"]),
          didAnswer: list[1]["didAnswer"])
    ]);
  });

  test("should return surverys on 200", () async {
    mockHttpError(HttpError.notFound);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

    test("should return  error on surverys on 500", () async {
    mockHttpError(HttpError.serverError);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });


    test("should throw accesDENIED surverys on 403", () async {
    mockHttpError(HttpError.forbidden);  
    final future = sut.load();
    expect(future, throwsA(DomainError.accessDenied));
  });
}
