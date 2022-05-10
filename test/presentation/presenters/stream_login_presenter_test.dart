import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/authentication.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/stream_login_presenter.dart';
import 'package:tdd_clean_patterns_solid/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;
  late String token;
  When mockValidationCall({String? field}) => when(
        () => validation.validate(
          field: field ?? any(named: "field"),
          value: any(named: "value"),
        ),
      );

  When mockAuthenticationCall() => when(
        () => authentication
            .auth(AuthenticationParams(email: email, secret: password)),
      );
  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  void mockValidation({String? field, required String value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    token = faker.jwt.toString();
  });
  test("should call validation with correct email", () {
    sut.validateEmail(email);

    verify(
      () => validation.validate(field: "email", value: email),
    ).called(1);
  });

  test("should emit email error if validation fails", () {
    mockValidation(value: "error");
    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
  });

  test("should emit null if validation succeds", () {
    sut.emailErrorStream?.listen(expectAsync1((error) => expect(error, "")));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, true)));
    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test("should call Validation with correct password", () {
    sut.validatePassword(password);
    verify(() => validation.validate(field: "password", value: password))
        .called(1);
  });

  test("should emit password error if validation fails", () {
    mockValidation(value: "error");
    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validateEmail(email);
  });

  test("should emit password error if entire validation fails", () {
    mockValidation(value: "error", field: "email");
    sut.passwordErrorStream?.listen(expectAsync1((error) => expect(error, "")));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.emailErrorStream
        ?.listen(expectAsync1((isValid) => expect(isValid, "error")));
    sut.validatePassword(password);
    sut.validateEmail(email);
  });

  test("should emit password error if entire validation fails case 2", () {
    sut.passwordErrorStream?.listen(expectAsync1((error) => expect(error, "")));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, true)));
    sut.emailErrorStream
        ?.listen(expectAsync1((isValid) => expect(isValid, "")));
    sut.validatePassword(password);
    sut.validateEmail(email);
  });

  test("should emit password error if entire validation fails case 3",
      () async {
    sut.emailErrorStream?.listen(expectAsync1((error) => expect(error, "")));
    sut.passwordErrorStream
        ?.listen(expectAsync1((isValid) => expect(isValid, "")));
    expectLater(sut.isFormValidStream, emits(true));
    sut.validateEmail(email);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
  });

  test("should call authentication with correct values", () async {
    mockAuthentication();
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    verify(
      () => authentication.auth(
        AuthenticationParams(email: email, secret: password),
      ),
    ).called(1);
  });

  test("should emit correct event on authentication success", () async {
    mockAuthentication();
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    await sut.auth();
  });

  test("should emit correct event on Invalid Credentials", () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream?.listen(
      expectAsync1(
        (error) => expect(error, "credenciais invalidas"),
      ),
    );
    await sut.auth();
  });

  test("should emit correct event on Unexpected Credentials", () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream?.listen(
      expectAsync1(
        (error) => expect(error, "unexpected error"),
      ),
    );
    await sut.auth();
  });

  test("should not emit after dispose", () async {
    expectLater(sut.emailErrorStream, neverEmits(null));
    sut.dispose();
    sut.validateEmail(email);
  });
}
