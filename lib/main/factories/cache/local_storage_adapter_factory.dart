

import 'package:localstorage/localstorage.dart';
import 'package:tdd_clean_patterns_solid/infra/cache/local_storage_adapter.dart';

LocalStorageAdapter makeLocalStorageAdapter() => LocalStorageAdapter(localStorage: LocalStorage("fordev"));