import 'package:flutter/cupertino.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/login_page.dart';

import 'signin_presenter_factory.dart';

Widget makeLoginPage() {
  return LoginPage(
    presenter: makeGetxLoginPresenter(),
  );
}
