import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

import '../../helpers/errors/ui_error.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get surveysStream;
  Future<void> loadData();
  void goToSurveyResult(String surveyId);
  Stream<String> get navigateToStream;
}
