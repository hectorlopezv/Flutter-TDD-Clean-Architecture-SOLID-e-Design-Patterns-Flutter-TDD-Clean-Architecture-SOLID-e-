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
  late String result;
  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    localStorage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  void mockDeleteCacheError() =>
      when(() => localStorage.deleteItem(any())).thenThrow(Exception());

  void mockSaveCacheError() =>
      when(() => localStorage.setItem(any(), any())).thenThrow(Exception());

  void mockFetch() =>
      when(() => localStorage.getItem(any())).thenAnswer((_) async => result);

  group("save", () {
    test("should call localStorage  save , adapter with correct values", () {
      sut.save(key: key, value: value);
      verify(() => localStorage.setItem(key, value)).called(1);
      verify(() => localStorage.deleteItem(key)).called(1);
      result = faker.randomGenerator.string(10);
    });

    test("should throw if deleteItem Throws", () {
      mockDeleteCacheError();
      final future = sut.save(key: key, value: value);
      expect(future, throwsA(TypeMatcher<Exception>()));
    });

    test("should throw if setItem Throws", () {
      mockSaveCacheError();
      final future = sut.save(key: key, value: value);
      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group("delete", () {
    test("should call localStorage  adapter, method delete with correct values",
        () {
      sut.delete(key);
      verify(() => localStorage.deleteItem(key)).called(1);
    });

    test("should throw if deleteItem THROWS", () {
      mockDeleteCacheError();
      final future = sut.delete(key);
      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group("fetch", () {
    test("should call localStorage  adapter, method delete with correct values",
        () {
      sut.fetch(key);
      verify(() => localStorage.getItem(key)).called(1);
    });

    test("should throw if deleteItem THROWS", () {
      mockDeleteCacheError();
      final future = sut.fetch(key);
      expect(future, throwsA(TypeMatcher<Exception>()));
    });

    test("should return same values as localStorage", () async {
      mockFetch();
      final data = await sut.fetch(key);
      expect(data, result);
    });
  });
}
