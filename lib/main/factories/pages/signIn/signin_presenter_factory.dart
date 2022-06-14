import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../usecases/authentication/authentication_factory.dart';
import '../../usecases/saveCurrentAccount/save_current_account_factory.dart';
import 'signin_validation_factory.dart';

GetxLoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
