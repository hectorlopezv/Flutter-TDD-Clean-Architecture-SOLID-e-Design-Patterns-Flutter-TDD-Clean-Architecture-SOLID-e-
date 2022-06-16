import 'package:flutter/cupertino.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/splash/splash_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surverys/surveys_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_page.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_page.dart';

Widget makeSurveysPage() {
  final presenter = makeGetxSurveysPresenter();
  return SurveysPage(presenter: presenter);
}
