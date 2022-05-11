import 'package:get/get.dart';

abstract class LoginPresenter {
  RxString get emailError;
  RxString get passwordError;
  RxString get mainError;
  RxBool get isFormValid;
  RxBool get isLoading;

  void auth();
  void dispose();
  void validateEmail(String email);
  void validatePassword(String password);
}
