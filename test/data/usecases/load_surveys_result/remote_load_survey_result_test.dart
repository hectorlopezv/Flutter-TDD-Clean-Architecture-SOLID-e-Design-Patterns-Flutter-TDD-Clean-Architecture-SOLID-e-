import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_survey_result.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';

class HttpClientSpy extends Mock implements HttpClientDemo<List<Map>> {}


void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadSurveysResult sut;
  late Map surveyResult;

  Map mockValidData() => 
        {
          "surveyId": faker.guid.guid(),
          "question": faker.lorem.sentence(),
          "date": faker.date.dateTime().toIso8601String(),
          "answers": [{
            "image": faker.internet.httpUrl(),
            "answer": faker.randomGenerator.string(20),
            "percent": faker.randomGenerator.integer(100),
            "count": faker.randomGenerator.integer(1000),
            "isCurrentAccountAnswer": faker.randomGenerator.boolean()
          }, 
          {
            "answer": faker.randomGenerator.string(20),
            "percent": faker.randomGenerator.integer(100),
            "count": faker.randomGenerator.integer(1000),
            "isCurrentAccountAnswer": faker.randomGenerator.boolean()
          }],
        }
       ;

  When mockRequest() => when(() => httpClient.request(
        url: any(named: "url"),
        method: any(named: "method"),
      ));
  void mockHttpData(Map data) {
    surveyResult = data;
    mockRequest().thenAnswer((_) => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadSurveysResult(url: url, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test("should call HttpClient with correct values", () async {
    await sut.loadBySurvey();

    verify(() => httpClient.request(url: url, method: "get")).called(1);
  });

  test("should return surverys on 200", () async {
    final result = await sut.loadBySurvey();

    expect(result, SurveyResultEntity(
      surveyId: surveyResult["surveyId"], 
      question: surveyResult["question"],
      answers: [
        SurveyAnswerEntity(
          percent: surveyResult["answers"][0]["percent"], 
          answer:  surveyResult["answers"][0]["answer"], 
          isCurrentAccountAnswer:  surveyResult["answers"][0]["isCurrentAccountAnswer"]),
        SurveyAnswerEntity(
          percent: surveyResult["answers"][1]["percent"], 
          answer:  surveyResult["answers"][1]["answer"], 
          isCurrentAccountAnswer:  surveyResult["answers"][1]["isCurrentAccountAnswer"])
    ]));
  });

  test("should return surverys on 200", () async {
    mockHttpError(HttpError.notFound);
    final future = sut.loadBySurvey();
    expect(future, throwsA(DomainError.unexpected));
  });

    test("should return  error on surverys on 500", () async {
    mockHttpError(HttpError.serverError);
    final future = sut.loadBySurvey();
    expect(future, throwsA(DomainError.unexpected));
  });


    test("should throw accesDENIED surverys on 403", () async {
    mockHttpError(HttpError.forbidden);  
    final future = sut.loadBySurvey();
    expect(future, throwsA(DomainError.accessDenied));
  });
}

