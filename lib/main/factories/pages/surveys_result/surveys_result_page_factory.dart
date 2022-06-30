

import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surveys_result/survey_results_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/surveys_result_page.dart';

Widget makeSurveysResultPage() {
  return SurveysResultPage(presenter: makeGetxSurveysResultPresenter(),);
}
