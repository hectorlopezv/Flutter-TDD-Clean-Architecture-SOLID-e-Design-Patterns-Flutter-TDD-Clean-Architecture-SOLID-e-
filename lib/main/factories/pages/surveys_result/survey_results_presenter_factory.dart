



import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_surveys_result_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';

SurveysResultPresenter makeGetxSurveysResultPresenter() {
  return GetxSurveysResultPresenter(loadSurveys: makeRemoteLoadSurveysWithLocalFallBack());
}
