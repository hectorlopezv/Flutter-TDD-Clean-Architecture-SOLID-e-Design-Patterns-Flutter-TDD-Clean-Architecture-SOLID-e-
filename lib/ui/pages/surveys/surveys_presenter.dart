import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get loadSurveysStream;
  Future<void> loadData();
}
