import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageAdapter {
  final LocalStorage localStorage;
  LocalStorageAdapter({required this.localStorage});
  Future<dynamic> save({required String key, required dynamic value}) {
    localStorage.setItem(key, value);
  }
}

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
  test("should call localStorage adapter with correct values", () {
    sut.save(key: key, value: value);
    verify(() => localStorage.setItem(key, value)).called(1);
  });
}
