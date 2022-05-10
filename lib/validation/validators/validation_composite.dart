import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';

class ValidationComposite implements Validation {
  late List<FieldValidation> validations;
  ValidationComposite(this.validations);
  @override
  String? validate({required String field, required String value}) {
    String? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value) ?? "";
      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return null;
  }
}
