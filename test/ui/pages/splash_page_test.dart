import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/splash/splash_page.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/splash/splash_presenter.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  final SplashPresenterSpy presenter = SplashPresenterSpy();
  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashPage(presenter: presenter))
      ],
    ));
  }

  testWidgets("should present loading spinner on page load",
      (WidgetTester tester) async {
    await loadPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("should call LoadCurrentAccount on pageLoad",
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadCurrentAccount()).called(1);
  });
}
