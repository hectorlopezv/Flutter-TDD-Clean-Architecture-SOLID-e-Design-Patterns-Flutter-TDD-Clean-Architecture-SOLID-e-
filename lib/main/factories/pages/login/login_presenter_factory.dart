import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../usecases/authentication/authentication_factory.dart';
import 'login_validation_factory.dart';

GetxLoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}
