import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';

import '../../data/cache/save_secure_cache_storage.dart';
import '../../domain/usecases/load_current_account/load_curret_account.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  // INTERFACE FROM DATA LAYER
  final FlutterSecureStorage secureStorage;
  LocalStorageAdapter({required this.secureStorage});
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
