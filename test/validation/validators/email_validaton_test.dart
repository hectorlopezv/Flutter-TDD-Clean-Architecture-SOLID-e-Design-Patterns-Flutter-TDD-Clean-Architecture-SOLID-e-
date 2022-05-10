import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_patterns_solid/validation/validators/email_validation.dart';

void main() {
  late EmailValidation sut;
  setUp(() {
    sut = EmailValidation("any_value");
  });
  test("should return null if email is empty", () {
    final response = sut.validate("");
    expect(response, null);
  });

  test("should return null if email is null", () {
    final response = sut.validate("");
    expect(response, null);
  });

  test("should return null if email is valid", () {
    final response = sut.validate("hector@gmail.com");
    expect(response, null);
  });
  test("should return error if email is invalid", () {
    final response = sut.validate("hectorgmail.com");
    expect(response, 'campo_invalido');
  });
}
