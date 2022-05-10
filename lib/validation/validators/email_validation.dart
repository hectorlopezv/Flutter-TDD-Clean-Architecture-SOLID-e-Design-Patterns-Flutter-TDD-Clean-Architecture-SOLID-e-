import 'package:equatable/equatable.dart';

import '../protocols/field_validation.dart';

class EmailValidation extends Equatable implements FieldValidation {
  List get props => [field];

  @override
  late final String field;
  @override
  String? validate(String value) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isValid = value.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : "campo_invalido";
  }

  EmailValidation(this.field);
}
