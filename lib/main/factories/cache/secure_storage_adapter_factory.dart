import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdd_clean_patterns_solid/infra/cache/secure_storage_adapter.dart';

SecureStorageAdapter makeSecureStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  return SecureStorageAdapter(secureStorage: secureStorage);
}
