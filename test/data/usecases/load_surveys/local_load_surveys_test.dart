import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/local_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';

class FetchCacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group("save", () {
    
  });
  group("validate", () {});
  group("load", () {
    late FetchCacheStorageSpy cacheStorage;
    late LocalLoadSurveys sut;
    late List<Map>? data;
    List<Map> mockValidData() => [
          {
            "id": faker.guid.guid(),
            "question": faker.randomGenerator.string(10),
            "date": "2020-01-01T00:00:00Z",
            "didAnswer": "false"
          },
          {
            "id": faker.guid.guid(),
            "question": faker.randomGenerator.string(10),
            "date": "2022-01-01T00:00:00Z",
            "didAnswer": "true"
          }
        ];
    void mockFetch(List<Map>? list) {
      data = list;
      when(() => cacheStorage.fetch(any())).thenAnswer((_) async => data);
    }

    void mockFetcError() {
      when(() => cacheStorage.fetch(any())).thenThrow(Exception());
    }

    setUp(() {
      cacheStorage = FetchCacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test("should call fetchCacheStorage with correct key", () async {
      await sut.load();

      verify(() => cacheStorage.fetch("surveys")).called(1);
    });

    test("should return a list of surveys on sucess", () async {
      final surveys = await sut.load();

      expect(surveys, [
        SurveryEntity(
            id: data?[0]["id"] ?? "",
            question: data?[0]["question"] ?? "",
            dateTime: DateTime.parse(data?[0]["date"] ?? ""),
            didAnswer: data?[0]["didAnswer"] == "true"),
        SurveryEntity(
            id: data?[1]["id"] ?? "",
            question: data?[1]["question"] ?? "",
            dateTime: DateTime.parse(data?[1]["date"] ?? ""),
            didAnswer: data?[1]["didAnswer"] == "true")
      ]);
    });

    test("should throw UnexpectedError if cache is empty", () async {
      mockFetch([]);
      final future = await sut.load();
      expect(future, throwsA(DomainError.unexpected));
    });

    test("should throw UnexpectedError if cache is null", () async {
      mockFetch(null);
      final future = await sut.load();
      expect(future, throwsA(DomainError.unexpected));
    });

    test("should throw UnexpectedError if cache is invalid", () async {
      mockFetch(null);
      final future = await sut.load();
      expect(future, throwsA(DomainError.unexpected));
    });

    test("should throw UnexpectedError if cache is incomplete", () async {
      mockFetch([
        {
          "date": "2019-02-02T00:0:00Z",
          "didAnswer": "false",
        }
      ]);
      final future = await sut.load();
      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
