import 'package:get/state_manager.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_current_account.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/authentication.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validation.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email = "";
  String _password = "";

  var emailError = "".obs;
  var passwordError = "".obs;
  var mainError = "".obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;
  var navigateTo = "".obs;

  Stream<String> get navigateToStream => navigateTo.stream;
  Stream<String> get emailErrorStream => emailError.stream;
  Stream<String> get passwordErrorStream => passwordError.stream;
  Stream<String> get mainErrorStream => mainError.stream;
  Stream<bool> get isFormValidStream => isFormValid.stream;
  Stream<bool> get isLoadingStream => isLoading.stream;

  GetxLoginPresenter(
      {required this.validation,
      required this.authentication,
      required this.saveCurrentAccount});

  void validateEmail(String email) {
    _email = email;
    emailError.value = validation.validate(field: 'email', value: email) ?? "";
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    passwordError.value =
        validation.validate(field: 'password', value: password) ?? "";
    _validateForm();
  }

  void _validateForm() {
    isFormValid.value = emailError.value == "" &&
        passwordError.value == "" &&
        _email != "" &&
        _password != "";
  }

  Future<void> auth() async {
    isLoading.value = true;
    try {
      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));

      await saveCurrentAccount.save(account);
      navigateTo.value = "/surveys";
    } on DomainError catch (error) {
      print(error);
      isLoading.value = false;
      mainError.value = error.description;
    }
  }

  void dispose() {}
}
