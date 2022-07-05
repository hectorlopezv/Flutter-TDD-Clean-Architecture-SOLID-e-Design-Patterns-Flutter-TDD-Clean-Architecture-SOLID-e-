import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

abstract class SurveysResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewModel?> get surveyResultStream;
  Future<void> loadData();

  Future<void> save({required String answer});
}
