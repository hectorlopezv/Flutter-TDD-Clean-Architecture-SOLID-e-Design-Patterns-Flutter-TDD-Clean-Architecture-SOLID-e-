import '../../../../presentation/protocols/validation.dart';
import '../../../../validation/protocols/field_validation.dart';
import '../../../../validation/validators/validation_composite.dart';
import '../../../builders/validation_builder.dart';

Validation makeSignInValidation() {
  return ValidationComposite(makeSignInValidations());
}

List<FieldValidation> makeSignInValidations() {
  return [
    ...ValidationBuilder.field('password').required().password().build(),
    ...ValidationBuilder.field('passwordConfirmation').required().sameAs("password").build(),
    ...ValidationBuilder.field('name').required().minLength(3).build(),
    ...ValidationBuilder.field('email').required().email().build(),
  ];
}
