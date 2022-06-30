import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import '../../data/cache/save_secure_cache_storage.dart';

class SecureStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  // INTERFACE FROM DATA LAYER
  final FlutterSecureStorage secureStorage;
  SecureStorageAdapter({required this.secureStorage});
  @override
  Future<void> saveSecure({required String key, required String value}) async {
    //ADAPTER CLASS/ INFRA LAYER
    await secureStorage.write(key: key, value: value);
  }

    @override
  Future<String?> fetchSecure(String key) async {
    //ADAPTER CLASS/ INFRA LAYER
    final value = await secureStorage.read(key: key);
    return value;
  }

}
