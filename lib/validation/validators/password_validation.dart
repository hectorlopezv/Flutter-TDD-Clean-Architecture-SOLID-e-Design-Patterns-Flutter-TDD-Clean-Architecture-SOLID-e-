import 'package:equatable/equatable.dart';

import '../protocols/field_validation.dart';

class PasswordValidation extends Equatable implements FieldValidation {
  @override
  List get props => [field];

  @override
  late final String field;
  @override
  String? validate(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final isValid = value.isNotEmpty || regex.hasMatch(value);
    return isValid ? null : "please_enter_valid_password";
  }

  PasswordValidation(this.field);
}
