import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/ui/components/app.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  var emailError = "".obs;
  var passwordError = "".obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;
  var mainError = "".obs;

  void mockStreams() {
    when(() => presenter.emailError).thenAnswer((_) => emailError);
    when(() => presenter.passwordError).thenAnswer((_) => passwordError);
    when(() => presenter.isFormValid).thenAnswer((_) => isFormValid);

    when(() => presenter.isLoading).thenAnswer((_) => isLoading);

    when(() => presenter.mainError).thenAnswer((_) => mainError);
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = Get.put<LoginPresenter>(LoginPresenterSpy());
    mockStreams();

    final loginPage = MaterialApp(
      home: App(
        presenter: presenter,
      ),
    );

    await tester.pumpWidget(loginPage);
  }

  testWidgets("should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

  testWidgets("should not present error if email is valid",
      (WidgetTester tester) async {
    await loadPage(tester);
    emailError.value = "";
    await tester.pump();
    expect(find.text('any error'), findsNothing);
  });
}
