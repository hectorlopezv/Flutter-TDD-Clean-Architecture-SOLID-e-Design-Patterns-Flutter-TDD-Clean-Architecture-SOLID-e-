import 'package:equatable/equatable.dart';
import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class EmailValidation extends Equatable implements FieldValidation {
  @override
  List get props => [field];

  @override
  late final String field;
  @override
  ValidationError? validate(Map input) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isValid = input[field].isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : ValidationError.invalidField;
  }

  EmailValidation(this.field);
}
