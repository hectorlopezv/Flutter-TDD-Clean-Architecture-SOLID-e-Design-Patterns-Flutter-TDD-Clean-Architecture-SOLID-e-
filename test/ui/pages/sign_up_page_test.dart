import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_page.dart';


void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final signUpPage = GetMaterialApp(
      initialRoute: "/signup",
      getPages: [
        GetPage(
          name: "/signup",
          page: () => SignUpPage(),
        ),
      ],
    );

    await tester.pumpWidget(signUpPage);
  }

  testWidgets("should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

}
