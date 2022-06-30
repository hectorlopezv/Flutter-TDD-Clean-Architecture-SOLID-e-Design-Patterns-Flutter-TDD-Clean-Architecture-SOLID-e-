import 'package:localstorage/localstorage.dart';

class LocalStorageAdapter {
  final LocalStorage localStorage;
  LocalStorageAdapter({required this.localStorage});
  Future<void> save({required String key, required dynamic value}) async {
    try {
      localStorage.deleteItem(key);
      localStorage.setItem(key, value);
    } catch (error) {
      rethrow;
    }
  }
}
