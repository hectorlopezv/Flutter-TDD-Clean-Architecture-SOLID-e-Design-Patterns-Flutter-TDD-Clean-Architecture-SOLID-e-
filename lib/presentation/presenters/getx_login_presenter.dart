import 'package:get/state_manager.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/authentication.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validation.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String _email = "";
  String _password = "";

  var emailError = "".obs;
  var passwordError = "".obs;
  var mainError = "".obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;

  GetxLoginPresenter({required this.validation, required this.authentication});

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
      await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
    } on DomainError catch (error) {
      mainError.value = error.description;
    }
    isLoading.value = false;
  }

  void dispose() {}
}
