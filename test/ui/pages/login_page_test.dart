import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/ui/components/app.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/login_presenter.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String> emailErrorController;
  late StreamController<String> passwordErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingErrorController;
  late StreamController<String> mainErrorController;

  void initStreams() {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingErrorController = StreamController<bool>();
    mainErrorController = StreamController<String>();
  }

  void mockStreams() {
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);

    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingErrorController.stream);

    when(() => presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
  }

  void closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    mainErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    initStreams();
    mockStreams();

    final loginPage = MaterialApp(
      home: App(
        presenter: presenter,
      ),
    );

    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets("should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);
    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel("Email"),
      matching: find.byType(Text),
    );
    expect(emailTextChildren, findsOneWidget);

    final passwrodTextChildren = find.descendant(
      of: find.bySemanticsLabel("passWord"),
      matching: find.byType(Text),
    );
    expect(passwrodTextChildren, findsOneWidget);
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

  testWidgets("should call validate with correct values",
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    final passWord = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel("Email"), email);
    await tester.enterText(find.bySemanticsLabel("passWord"), passWord);
    await tester.pump();
    verify(() => presenter.validateEmail(email));
    verify(() => presenter.validatePassword(passWord));
  });

  testWidgets("should present error if email is invalid",
      (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add("any error");
    await tester.pump();
    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets("should not present error if email is valid",
      (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add("");
    await tester.pump();
    expect(find.text('any error'), findsNothing);
  });

  testWidgets("should present error if Senha is invalid",
      (WidgetTester tester) async {
    await loadPage(tester);
    passwordErrorController.add("any error");
    await tester.pump();
    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets("should not present error if Senha is valid",
      (WidgetTester tester) async {
    await loadPage(tester);
    passwordErrorController.add("");
    await tester.pump();
    expect(find.text('any error'), findsNothing);
  });

  testWidgets("should enable button if form is valid",
      (WidgetTester tester) async {
    await loadPage(tester);
    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<RaisedButton>(
      find.byType(RaisedButton),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets("should call authentication on form submit button",
      (WidgetTester tester) async {
    await loadPage(tester);
    isFormValidController.add(true);
    await tester.pump();
    await tester.ensureVisible(
      find.text('ENTRAR'),
    );
    await tester.tap(
      find.text('ENTRAR'),
    );
    await tester.pumpAndSettle();
    await tester.pump();
    verify(
      () => presenter.auth(),
    ).called(1);
  });

  testWidgets("should present loading", (WidgetTester tester) async {
    await loadPage(tester);
    isLoadingErrorController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("should hide loading", (WidgetTester tester) async {
    await loadPage(tester);
    isLoadingErrorController.add(true);
    await tester.pump();
    isLoadingErrorController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("should present error message if authentication fails",
      (WidgetTester tester) async {
    await loadPage(tester);
    mainErrorController.add("main error");
    await tester.pump();
    expect(find.text("main error"), findsOneWidget);
  });

  testWidgets("should close streams on dispose", (WidgetTester tester) async {
    await loadPage(tester);
    addTearDown(() {
      verify(() => presenter.dispose()).called(1);
    });
  });
}
