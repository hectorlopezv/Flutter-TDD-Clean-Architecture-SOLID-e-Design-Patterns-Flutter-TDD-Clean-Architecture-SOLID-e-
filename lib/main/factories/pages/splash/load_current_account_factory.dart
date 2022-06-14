import 'package:tdd_clean_patterns_solid/data/usecases/load_save_current_account/local_load_current_account.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_current_account/load_curret_account.dart';
import 'package:tdd_clean_patterns_solid/main/factories/cache/local_storage_adapter_factory.dart';

  LoadCurrentAccount makeLocalLoadCurrentAccount() {
    return LocalLoadCurrentAccount(
        fetchSecureCacheStorage: makeLocalStorageAdapter());
  } 
