import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/infra/cache/local_storage_adapter.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  late final FlutterSecureStorageSpy secureStorage;
  late final sut;
  late final key;
  late final value;
  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  test("should call save secure(flutter cache storage) with correct values",
      () async {
    await sut.saveSecure(key: key, value: value);
    verify(
      () => secureStorage.write(key: key, value: value),
    );
  });

  test(
      "should throw error when execption occurs save secure(flutter cache storage)",
      () async {
    when(
      () => secureStorage.write(
        key: any(named: "key"),
        value: any(named: "value"),
      ),
    ).thenThrow(Exception());
    final future = await sut.saveSecure(key: key, value: value);
    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
