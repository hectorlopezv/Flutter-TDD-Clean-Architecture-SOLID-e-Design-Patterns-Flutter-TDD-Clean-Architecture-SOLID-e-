import 'package:get/state_manager.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_current_account/save_current_account.dart';
import 'package:tdd_clean_patterns_solid/presentation/mixins/loading_manager.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usecases/authentication/authentication.dart';
import '../../ui/pages/login/login_presenter.dart';
import '../protocols/validation.dart';

class GetxLoginPresenter extends GetxController
    with LoadingManager
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email = "";
  String _password = "";

  var emailError = Rx<UIError?>(null);
  var passwordError = Rx<UIError?>(null);
  var mainError = Rx<UIError?>(null);
  var isFormValid = false.obs;

  var navigateTo = "".obs;

  Stream<String> get navigateToStream => navigateTo.stream;
  Stream<UIError?> get emailErrorStream => emailError.stream;
  Stream<UIError?> get passwordErrorStream => passwordError.stream;
  Stream<UIError?> get mainErrorStream => mainError.stream;
  Stream<bool> get isFormValidStream => isFormValid.stream;

  GetxLoginPresenter(
      {required this.validation,
      required this.authentication,
      required this.saveCurrentAccount});

  void validateEmail(String email) {
    _email = email;
    emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      "email": _email,
      "password": _password,
    };
    final error = validation.validate(field: field, input: formData);
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
    isFormValid.value = emailError.value == null &&
        passwordError.value == null &&
        _email != "" &&
        _password != "";
  }

  Future<void> auth() async {
    isLoading = true;
    mainError.value = null;
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
      isLoading = false;
    }
  }

  void dispose() {}

  void goToSignUp() {
    navigateTo.value = "/signup";
  }
}
