import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class ValidationComposite implements Validation {
  late List<FieldValidation> validations;
  ValidationComposite(this.validations);
  @override
  ValidationError? validate({required String field, required String value}) {
     ValidationError? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}
