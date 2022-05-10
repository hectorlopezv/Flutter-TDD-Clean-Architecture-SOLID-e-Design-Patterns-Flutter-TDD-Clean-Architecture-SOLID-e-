import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../../../presentation/presenters/stream_login_presenter.dart';
import '../../../../ui/pages/login/login_presenter.dart';
import '../../usecases/authentication/authentication_factory.dart';
import 'login_validation_factory.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}

GetxLoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}
