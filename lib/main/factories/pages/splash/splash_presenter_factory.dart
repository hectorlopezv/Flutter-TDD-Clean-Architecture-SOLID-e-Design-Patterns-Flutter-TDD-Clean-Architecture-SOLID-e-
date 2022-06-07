import 'package:tdd_clean_patterns_solid/main/factories/pages/splash/load_current_account_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/get_splash_presenter.dart';

 GetXSplashPresenter makeGetxLoginPresenter() {
  return GetXSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
}
