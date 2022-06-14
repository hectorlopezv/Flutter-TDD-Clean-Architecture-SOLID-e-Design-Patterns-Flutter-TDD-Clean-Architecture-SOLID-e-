import 'package:tdd_clean_patterns_solid/validation/validators/password_validation.dart';

import '../../validation/protocols/field_validation.dart';
import '../../validation/validators/email_validation.dart';
import '../../validation/validators/required_field_validation.dart';

class ValidationBuilder {
  static final ValidationBuilder _instance = ValidationBuilder();
  late String fieldName;
  List<FieldValidation> validations = [];

  static ValidationBuilder field(String fieldName) {
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder password() {
    validations.add(PasswordValidation(fieldName));
    return this;
  }

    ValidationBuilder minLength() {
    validations.add(PasswordValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
