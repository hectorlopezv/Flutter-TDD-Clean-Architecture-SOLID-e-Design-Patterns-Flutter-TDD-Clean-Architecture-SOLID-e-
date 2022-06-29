import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/models/local_survey_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';

import '../../../main/decorators/authorize_http_client_decorator_test.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;
  LocalLoadSurveys({required this.fetchCacheStorage});
  Future<List<SurveryEntity>> load() async {
    final data = await fetchCacheStorage.fetch("surveys");
    return data.map<SurveryEntity>((json)=> LocalSurveyModel.fromJson(json).toEntity()).toList();
  }
}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadSurveys sut;
  late List<Map> data;
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
  void mockFetch(List<Map> list) {
    data = list;
    when(() => fetchCacheStorage.fetch(any())).thenAnswer((_) async => data);
  }

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
    mockFetch(mockValidData());
  });

  test("should call fetchCacheStorage with correct key", () async {
    await sut.load();

    verify(() => fetchCacheStorage.fetch("surveys")).called(1);
  });

  test("should return a list of surveys on sucess", () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveryEntity(
          id: data[0]["id"] ?? "",
          question: data[0]["question"] ?? "",
          dateTime: DateTime.parse(data[0]["date"] ?? ""),
          didAnswer: data[0]["didAnswer"] == "true"),
      SurveryEntity(
          id: data[1]["id"] ?? "",
          question: data[1]["question"] ?? "",
          dateTime: DateTime.parse(data[1]["date"] ?? ""),
          didAnswer: data[1]["didAnswer"] == "true")
    ]);
  });
}
