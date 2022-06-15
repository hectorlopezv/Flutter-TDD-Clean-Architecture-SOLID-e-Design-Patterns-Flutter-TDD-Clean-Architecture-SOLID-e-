import 'package:tdd_clean_patterns_solid/main/factories/usecases/addAccount/add_account_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_signin_presenter.dart';
import '../../usecases/saveCurrentAccount/save_current_account_factory.dart';
import '../login/login_validation_factory.dart';
import 'signin_validation_factory.dart';

GetxSignInPresenter makeGetxSignInPresenter() {
  return GetxSignInPresenter(
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
    addAccount: makeRemoteAddAcccount(),
  );
}
