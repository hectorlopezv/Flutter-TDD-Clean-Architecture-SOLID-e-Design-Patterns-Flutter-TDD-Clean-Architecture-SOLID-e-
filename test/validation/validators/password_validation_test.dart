import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_patterns_solid/validation/validators/password_validation.dart';

void main() {
  late PasswordValidation sut;
  setUp(() {
    sut = PasswordValidation("password");
  });
  test("should return null if email is empty", () {
    final response = sut.validate("");
    expect(response, "please_enter_valid_password");
  });

  test("should return null if email is valid", () {
    final response = sut.validate("PepeFm@.@");
    expect(response, null);
  });
}
