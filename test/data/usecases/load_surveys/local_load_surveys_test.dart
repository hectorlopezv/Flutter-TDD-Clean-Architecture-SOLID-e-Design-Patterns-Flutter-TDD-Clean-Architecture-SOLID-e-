import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';

import '../../../main/decorators/authorize_http_client_decorator_test.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;
  LocalLoadSurveys({required this.fetchCacheStorage});
  Future<void> load() async {
    await fetchCacheStorage.fetch("surveys");
  }
}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadSurveys sut;
  setUp(() {
       fetchCacheStorage = FetchCacheStorageSpy();
     sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
  });
  test("should call fetchCacheStorage with correct key", () async {

    await sut.load();

    verify(() => fetchCacheStorage.fetch("surveys")).called(1);
  });
}
