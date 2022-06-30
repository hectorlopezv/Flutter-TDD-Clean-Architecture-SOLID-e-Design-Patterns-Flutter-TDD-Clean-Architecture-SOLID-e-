import 'package:tdd_clean_patterns_solid/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_current_account/save_current_account.dart';
import 'package:tdd_clean_patterns_solid/main/factories/cache/secure_storage_adapter_factory.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() {
  final saveSecureCacheStorage = makeSecureStorageAdapter();
  return LocalSaveCurrentAccount(
      saveSecureCacheStorage: saveSecureCacheStorage);
}
