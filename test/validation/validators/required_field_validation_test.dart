import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_patterns_solid/validation/validators/required_field_validation.dart';

void main() {
  late RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation("");
  });
  test("should return string if value is not empty", () {
    final response = sut.validate("any_value");
    expect(response, null);
  });

  test("should return empty error if value is empty", () {
    final response = sut.validate("");
    expect(response, "");
  });
}
