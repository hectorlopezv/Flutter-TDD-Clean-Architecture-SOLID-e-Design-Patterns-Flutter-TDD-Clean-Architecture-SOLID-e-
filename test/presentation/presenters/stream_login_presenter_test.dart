import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/stream_login_presenter.dart';
import 'package:tdd_clean_patterns_solid/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;
  When mockValidationCall({String? field}) => when(
        () => validation.validate(
          field: field ?? any(named: "field"),
          value: any(named: "value"),
        ),
      );

  void mockValidation({String? field, required String value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });
  test("should call validation with correct email", () {
    sut.validateEmail(email);

    verify(
      () => validation.validate(field: "email", value: email),
    ).called(1);
  });

  test("should emit email error if validation fails", () {
    mockValidation(value: "error");
    expectLater(sut.emailErrorStream, emits("error"));

    sut.validateEmail(email);
  });
}
