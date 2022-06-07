import 'package:get/state_manager.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_current_account.dart';
import 'package:tdd_clean_patterns_solid/main/main.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';

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

  var emailError = Rx<UIError?>(null);
  var passwordError = Rx<UIError?>(null);
  var mainError = Rx<UIError?>(null);
  var isFormValid = false.obs;
  var isLoading = false.obs;
  var navigateTo = "".obs;

  Stream<String> get navigateToStream => navigateTo.stream;
  Stream<UIError?> get emailErrorStream => emailError.stream;
  Stream<UIError?> get passwordErrorStream => passwordError.stream;
  Stream<UIError?> get mainErrorStream => mainError.stream;
  Stream<bool> get isFormValidStream => isFormValid.stream;
  Stream<bool> get isLoadingStream => isLoading.stream;

  GetxLoginPresenter(
      {required this.validation,
      required this.authentication,
      required this.saveCurrentAccount});

  void validateEmail(String email) {
    _email = email;
    emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  UIError? _validateField({required String field, required String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    isFormValid.value = emailError.value != "" &&
        passwordError.value != "" &&
        _email != "" &&
        _password != "";
  }

  Future<void> auth() async {
    isLoading.value = true;
    try {
      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
      print("Acpount: $account");
      await saveCurrentAccount.save(account);
      navigateTo.value = "/surveys";
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError.value = UIError.invalidCredentials;
          break;
        default:
          mainError.value = UIError.unexpected;
          break;
      }
      isLoading.value = false;
    }
  }

  void dispose() {}
}
