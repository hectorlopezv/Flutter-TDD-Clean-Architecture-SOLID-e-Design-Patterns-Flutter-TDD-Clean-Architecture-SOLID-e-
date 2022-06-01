import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/cache/save_secure_cache_storage.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  // INTERFACE FROM DATA LAYER
  final FlutterSecureStorage secureStorage;
  LocalStorageAdapter({required this.secureStorage});
  @override
  Future<void> saveSecure({required String key, required String value}) async {
    //ADAPTER CLASS/ INFRA LAYER
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> fetchSecure({required String key}) async {
    //ADAPTER CLASS/ INFRA LAYER

    final value = await secureStorage.read(key: key);
    return value;
  }
}
