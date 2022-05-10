import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/validation/protocols/field_validation.dart';
import 'package:tdd_clean_patterns_solid/validation/validators/validation_composite.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;
  late ValidationComposite sut;
  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();
    sut = ValidationComposite([validation1, validation2, validation2]);
  });
  void mockValidation1(String? error) {
    when(
      () => validation1.validate(
        any(),
      ),
    ).thenReturn(error);
  }

  void mockValidation2(String? error) {
    when(
      () => validation2.validate(
        any(),
      ),
    ).thenReturn(error);
  }

  void mockValidation3(String? error) {
    when(
      () => validation3.validate(
        any(),
      ),
    ).thenReturn(error);
  }

  test("should return null if all validations return null or empty", () {
    when(() => validation1.field).thenReturn("any_field");
    mockValidation1(null);

    when(() => validation2.field).thenReturn("any_field");
    mockValidation2("");
    mockValidation3(null);
    final error = sut.validate(field: "any_field", value: "any_field");
    expect(error, null);
  });

  test("should return the first error found", () {
    mockValidation1("error_1");
    mockValidation2("error_2");
    mockValidation3("error_3");
    final error = sut.validate(field: "any_field", value: "any_field");
    expect(error, "error_1");
  });
}
