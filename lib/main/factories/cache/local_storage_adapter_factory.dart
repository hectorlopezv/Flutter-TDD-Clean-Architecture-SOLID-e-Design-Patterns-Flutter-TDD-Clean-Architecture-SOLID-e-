import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdd_clean_patterns_solid/infra/cache/local_storage_adapter.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  return LocalStorageAdapter(secureStorage: secureStorage);
}
