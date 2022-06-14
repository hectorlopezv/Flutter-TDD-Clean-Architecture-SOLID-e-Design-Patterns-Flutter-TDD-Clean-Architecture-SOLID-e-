import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_page.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_presenter.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  late SignUpPresenter presenter;
  late StreamController<UIError?> emailErrorController;
  late StreamController<UIError?> nameErrorController;
  late StreamController<UIError?> passwordErrorController;
  late StreamController<UIError?> passwordConfirmationErrorController;

  void initStreams() {
    nameErrorController = StreamController<UIError?>();
    emailErrorController = StreamController<UIError?>();
    passwordErrorController = StreamController<UIError?>();
    passwordConfirmationErrorController = StreamController<UIError?>();
  }

  void mockStreams() {
    when(() => presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
  }

  tearDown(() {
    closeStreams();
  });

  Future<void> loadPage(WidgetTester tester) async {
    presenter = Get.put<SignUpPresenter>(SignUpPresenterSpy());
    initStreams();
    mockStreams();
    final signUpPage = GetMaterialApp(
      initialRoute: "/signup",
      getPages: [
        GetPage(
          name: "/signup",
          page: () => SignUpPage(presenter: presenter),
        ),
      ],
    );

    await tester.pumpWidget(signUpPage);
  }

  setUp(() {});

  testWidgets("should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

  testWidgets("should call validate with correct values",
      (WidgetTester tester) async {
    await loadPage(tester);
    final name = faker.person.name();
    final email = faker.internet.email();
    final password = faker.internet.password();

    await tester.enterText(find.bySemanticsLabel("Nome"), name);
    verify(() => presenter.validateName(name));

    await tester.enterText(find.bySemanticsLabel("Email"), email);
    verify(() => presenter.validatePassword(name));

    await tester.enterText(find.bySemanticsLabel("Confirmar senha"), password);
    verify(() => presenter.validatePasswordConfirmation(name));
  });
}
