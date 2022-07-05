import 'package:flutter/cupertino.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_page.dart';
import 'signin_presenter_factory.dart';

Widget makeSignInPage() {
  return SignUpPage(
    presenter: makeGetxSignInPresenter(),
  );
}
