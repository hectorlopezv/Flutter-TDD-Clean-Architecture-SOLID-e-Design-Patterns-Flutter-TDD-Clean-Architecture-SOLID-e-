import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/cache/save_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  late final SaveSecureCacheStorage saveSecureCacheStorage;
  late final LocalSaveCurrentAccount sut;
  late final AccountEntity account;
  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });
  void mockError() {
    when(
      () => saveSecureCacheStorage.saveSecure(
        key: any(named: "key"),
        value: any(named: "value"),
      ),
    ).thenThrow(Exception());
  }

  test("should call saveCacheStorage with correct values", () async {
    await sut.save(account);

    verify(() =>
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test("should throw UnexpectedError if saveCacheStorage throws", () async {
    mockError();
    final future = await sut.save(account);

    verify(() =>
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));

    expect(future, throwsA(DomainError.unexpected));
  });
}
