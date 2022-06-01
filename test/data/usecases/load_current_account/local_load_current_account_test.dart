import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_save_current_account/local_load_current_account.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;
  void mockFetchSecure() {
    when(
      () => fetchSecureCacheStorage.fetchSecure(
        any(),
      ),
    ).thenAnswer((_) async => token);
  }

  void mockFetchSecureError() {
    when(
      () => fetchSecureCacheStorage.fetchSecure(
        any(),
      ),
    ).thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });

  test("should call FetchSecureCacheStorage with correct value", () async {
    await sut.load();
    verify(
      () => fetchSecureCacheStorage.fetchSecure("token"),
    );
  });
  test("should return an AccountEntity", () async {
    final account = await sut.load();
    expect(account, AccountEntity(token));
  });

  test("should throw  UnexpectedError if FetchSecureCacheStorage Throws",
      () async {
    mockFetchSecureError();
    final future = sut.load();
    expect(
      future,
      throwsA(DomainError.unexpected),
    );
  });
}
