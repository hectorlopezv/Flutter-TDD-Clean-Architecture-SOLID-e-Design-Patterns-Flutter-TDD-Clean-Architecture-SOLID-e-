import 'package:localstorage/localstorage.dart';
import 'package:tdd_clean_patterns_solid/data/cache/cache_storage.dart';

class LocalStorageAdapter implements CacheStorage {
  final LocalStorage localStorage;
  LocalStorageAdapter({required this.localStorage});

  @override
  Future<void> save({required String key, required dynamic value}) async {
    try {
     await localStorage.deleteItem(key);
      await localStorage.setItem(key, value);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
     await localStorage.deleteItem(key);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fetch(String key)  async{
    try {
     return await localStorage.getItem(key);
    } catch (error) {
      rethrow;
    }
  }


}
