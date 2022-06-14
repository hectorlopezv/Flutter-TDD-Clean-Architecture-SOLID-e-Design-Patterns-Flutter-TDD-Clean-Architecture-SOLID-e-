import 'package:get/get.dart';

import '../../domain/entities/account_entity.dart';
import '../../domain/usecases/load_current_account/load_curret_account.dart';
import '../../ui/pages/splash/splash_presenter.dart';

class GetXSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString("");
  GetXSplashPresenter({required this.loadCurrentAccount});
  @override
  Future<AccountEntity?> checkAccount({int durationInSeconds = 2}) async {
    Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account != null ? "/login" : "/surveys";
      return account;
    } catch (error) {
      _navigateTo.value = "/login";
    }
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}
