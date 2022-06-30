import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/infra/cache/local_storage_adapter.dart';



class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  late String key;
  late String value;
  late LocalStorageSpy localStorage;
  late LocalStorageAdapter sut;
  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    localStorage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  void mockDeleteItemError() => when(() => localStorage.deleteItem(any())).thenThrow(Exception());

  void mockSetItemError() => when(() => localStorage.setItem(any(), any())).thenThrow(Exception());
  test("should call localStorage adapter with correct values", () {
    sut.save(key: key, value: value);
    verify(() => localStorage.setItem(key, value)).called(1);
    verify(() => localStorage.deleteItem(key)).called(1);
  });

  test("should throw if deleteItem Throws", () {
    mockDeleteItemError();
    final future = sut.save(key: key, value: value);
    expect(future, throwsA(TypeMatcher<Exception>()));
  });

    test("should throw if setItem Throws", () {
    mockSetItemError();
    final future = sut.save(key: key, value: value);
    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
