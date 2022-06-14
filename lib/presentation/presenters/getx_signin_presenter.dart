import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/add_account/add_account.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_presenter.dart';
import '../../domain/usecases/save_current_account/save_current_account.dart';
import '../../ui/helpers/errors/ui_error.dart';
import '../protocols/validation.dart';

class GetxSignInPresenter extends GetxController implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;
  String _email = "";
  String _password = "";
  String _passwordConfirmation = "";
  String _name = "";

  final _isFormValid = false.obs;
  final _navigateTo = "".obs;
  final _isLoading = false.obs;
  final _mainError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _nameError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);

  GetxSignInPresenter(
      {required this.validation,
      required this.addAccount,
      required this.saveCurrentAccount});

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
    _isFormValid.value = _emailError.value != "" &&
        _nameError.value != "" &&
        _passwordError.value != "" &&
        _passwordConfirmationError.value != "";
  }

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;

  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;

  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Stream<UIError?> get mainErrorStream => _mainError.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  @override
  Future<void> signUp() async {
    _isLoading.value = true;
    try {
      final account = await addAccount.add(AddAccountParams(
          email: _email,
          name: _name,
          password: _password,
          passwordConfirmation: _passwordConfirmation));
      await saveCurrentAccount.save(account);
      _navigateTo.value = "/surveys";
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _mainError.value = UIError.invalidCredentials;
          break;
        default:
          _mainError.value = UIError.unexpected;
          break;
      }
      _isLoading.value = false;
    }
  }

  void goToLogin() {
    _navigateTo.value = "/signup";
  }
}
