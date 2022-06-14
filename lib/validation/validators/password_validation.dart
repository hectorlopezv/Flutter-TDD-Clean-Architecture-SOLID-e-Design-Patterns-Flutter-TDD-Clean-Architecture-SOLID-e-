import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class PasswordValidation extends Equatable implements FieldValidation {
  @override
  List get props => [field];

  @override
  late final String field;
  @override
   ValidationError? validate(Map input) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final isValid = regex.hasMatch(input[field]);
    return isValid ? null : ValidationError.invalidField;
  }

  PasswordValidation(this.field);
}
