import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_presenter.dart';
import '../../ui/helpers/errors/ui_error.dart';
import '../protocols/validation.dart';

class GetxSignInPresenter extends GetxController implements SignUpPresenter {
  final Validation validation;
  String _email = "";
  String _password = "";
  final _isFormValid = false.obs;
  final _emailError = Rx<UIError?>(null);


  GetxSignInPresenter({required this.validation});

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
    _isFormValid.value = false;
  }

  @override
  // TODO: implement emailErrorStream
  Stream<UIError?> get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  // TODO: implement nameErrorStream
  Stream<UIError?> get nameErrorStream => throw UnimplementedError();

  @override
  // TODO: implement navigateToStream
  Stream<String> get navigateToStream => throw UnimplementedError();

  @override
  // TODO: implement passwordConfirmationErrorStream
  Stream<UIError?> get passwordConfirmationErrorStream =>
      throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<UIError?> get passwordErrorStream => throw UnimplementedError();

  @override
  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validateName(String name) {
    // TODO: implement validateName
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    // TODO: implement validatePasswordConfirmation
  }

  @override
  // TODO: implement mainErrorStream
  Stream<UIError?> get mainErrorStream => throw UnimplementedError();
}
