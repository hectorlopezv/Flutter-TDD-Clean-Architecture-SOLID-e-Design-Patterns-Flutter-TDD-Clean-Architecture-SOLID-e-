import 'package:flutter/cupertino.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/splash/splash_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() {
  return SplashPage(
    presenter: makeGetxLoginPresenter()
  );
}
