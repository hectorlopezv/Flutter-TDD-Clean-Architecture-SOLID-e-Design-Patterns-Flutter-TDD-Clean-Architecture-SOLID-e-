import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/domain_error.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/authentication/authentication.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_current_account/save_current_account.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_login_presenter.dart';
import 'package:tdd_clean_patterns_solid/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;
  late String token;
  late SaveCurrentAccountSpy saveCurrentAccount;
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

  When mockSaveCurrentAccountCall() => when(
        () => saveCurrentAccount.save(
          any(named: "account"),
        ),
      );

  void makeSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

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
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxLoginPresenter(
        validation: validation,
        authentication: authentication,
        saveCurrentAccount: saveCurrentAccount);
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
    sut.emailError.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValid.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
  });

  test("should emit password error if validation fails", () {
    mockValidation(value: "error");
    sut.passwordError.listen(expectAsync1((error) => expect(error, "error")));
    sut.isFormValid.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validateEmail(email);
  });

  test("should emit password error if entire validation fails", () {
    mockValidation(value: "error", field: "email");
    sut.passwordError.listen(expectAsync1((error) => expect(error, "")));
    sut.isFormValid.listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.emailError.listen(expectAsync1((isValid) => expect(isValid, "error")));
    sut.validatePassword(password);
    sut.validateEmail(email);
  });

  test("should emit correct event on Invalid Credentials", () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.mainError.listen(
      expectAsync1(
        (error) => expect(error, "credenciais invalidas"),
      ),
    );
    await sut.auth();
  });

  test("should call SaveCurrentAccount with correct values", () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    verify(() => saveCurrentAccount.save(AccountEntity(token))).called(1);
  });

  test("should emit unexpectedError if saveCurrentAccount fails", () async {
    makeSaveCurrentAccountError();

    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    expectLater(sut.isLoading, emits(true));
    sut.mainError.listen(
      expectAsync1(
        (error) => expect(error, "algo errado sucedio"),
      ),
    );
  });
}
