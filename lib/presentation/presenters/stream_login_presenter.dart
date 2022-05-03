import 'dart:async';

import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/authentication.dart';

import '../protocols/validation.dart';

class LoginState {
  late String? email;
  late String? password;
  late String? emailError;
  late String? passwordError;
  late bool? isLoading;
  late String mainError;
  bool? get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((event) => event.emailError).distinct();
  Stream<String?> get mainErrorStream =>
      _controller.stream.map((event) => event.mainError).distinct();
  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((event) => event.passwordError).distinct();
  Stream<bool?> get isFormValidStream =>
      _controller.stream.map((event) => event.isFormValid).distinct();

  Stream<bool?> get isLoadingStream =>
      _controller.stream.map((event) => event.isLoading).distinct();

  StreamLoginPresenter(
      {required this.validation, required this.authentication});

  void _update() {
    if (!_controller.isClosed) {
      _controller.add(_state);
    }
  }

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: "email", value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: "password", value: password);
    _update();
  }

  Future<AccountEntity?> auth() async {
    _state.isLoading = true;
    _update();
    AccountEntity? response;

    try {
      response = await authentication.auth(
        AuthenticationParams(
            email: _state.email ?? "", secret: _state.password ?? ""),
      );
    } on DomainError catch (error) {
      _state.mainError = error.description;
      response = null;
    }
    _state.isLoading = false;
    _update();
    return response;
  }

  void dispose() {
    _controller.close();
  }
}
