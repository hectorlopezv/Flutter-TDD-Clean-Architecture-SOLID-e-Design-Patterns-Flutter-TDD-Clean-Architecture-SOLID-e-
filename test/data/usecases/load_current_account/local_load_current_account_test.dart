import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});
  Future<void> load() async {
    await fetchSecureCacheStorage.fetchSecure("token");
  }
}

abstract class FetchSecureCacheStorage {
  Future<void> fetchSecure(String key) async {}
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  setUp(() {});
  test("should call FetchSecureCacheStorage with correct value", () async {
    final fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    final sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    await sut.load();

    verify(
      () => fetchSecureCacheStorage.fetchSecure("token"),
    );
  });
  ;
}
