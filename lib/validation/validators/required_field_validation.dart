import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class RequiredFieldValidation implements FieldValidation {
  List get props => [field];
  RequiredFieldValidation(this.field);

  @override
  late final String field;
  @override
  ValidationError? validate(Map input) {
    return input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
  }
}
