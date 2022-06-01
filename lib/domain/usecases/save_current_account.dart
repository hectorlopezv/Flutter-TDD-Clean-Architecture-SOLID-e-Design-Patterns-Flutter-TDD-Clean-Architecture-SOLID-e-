import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity account);
}
