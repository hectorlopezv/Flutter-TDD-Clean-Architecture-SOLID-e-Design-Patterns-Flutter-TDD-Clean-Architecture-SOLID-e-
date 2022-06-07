import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';

abstract class SplashPresenter {
  Future<AccountEntity?> checkAccount();
  Stream<String> get navigateToStream;
}
