import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/local_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/main/composites/remote_load_surveys_with_fallback.dart';

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {}

class LocalLoadSurveySpy extends Mock implements LocalLoadSurveys {}

void main() {
  late RemoteLoadSurveysSpy remote;
  late LocalLoadSurveySpy local;
  late RemoteLoadSurveysWithLocalFallBack sut;
  late List<SurveryEntity> surveys;
  List<SurveryEntity> mockSurveys() => [
        SurveryEntity(
            id: faker.guid.guid(),
            question: faker.randomGenerator.string(10),
            dateTime: faker.date.dateTime(),
            didAnswer: faker.randomGenerator.boolean())
      ];
  void mockRemoteLoad() {
    surveys = mockSurveys();
    when(() => remote.load()).thenAnswer((_) async => surveys);
  }

  When mockRemoteLoadCall() => when(() => remote.load());

  void mockRemoteLoadError(DomainError error) {
    mockRemoteLoadCall().thenThrow(error);
  }

  setUp(() {
    remote = RemoteLoadSurveysSpy();
    local = LocalLoadSurveySpy();
    sut = RemoteLoadSurveysWithLocalFallBack(remote: remote, local: local);
    mockRemoteLoad();
  });

  test("should call remote load", () async {
    await sut.load();
    verify(() => remote.load()).called(1);
  });

  test("should call local save with remote data", () async {
    await sut.load();
    verify(() => local.save(surveys)).called(1);
  });

  test("should return remote data", () async {
    final result = await sut.load();
    expect(result, surveys);
  });

  test("should retTHROW if remote load throws AccessDeniedError", () async {
    mockRemoteLoadError(DomainError.accessDenied);

    final future = sut.load();
    expect(future, throwsA(DomainError.accessDenied));
  });

  test("should call local fetch on remote error", () async {
    mockRemoteLoadError(DomainError.unexpected);

    await sut.load();

    verify(() => local.validate()).called(1);
    verify(() => local.load()).called(1);
  });
}
