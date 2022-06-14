import '../../helpers/errors/ui_error.dart';

abstract class LoginPresenter {
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get mainErrorStream;
  Stream<String> get navigateToStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void auth();
  void dispose();
  void validateEmail(String email);
  void validatePassword(String password);
  void goToSignUp();
}
