import '../protocols/field_validation.dart';

class RequiredFieldValidation implements FieldValidation {
  List get props => [field];
  RequiredFieldValidation(this.field);

  @override
  late final String field;
  @override
  String? validate(String value) {
    return value.isNotEmpty == true ? null : value;
  }
}
