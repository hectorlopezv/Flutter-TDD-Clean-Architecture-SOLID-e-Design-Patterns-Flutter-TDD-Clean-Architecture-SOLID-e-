import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/usecases/load_survey_result/load_survey_result_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_surveys_result_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';

SurveysResultPresenter makeGetxSurveysResultPresenter() {
  final surveyId = Get.parameters["survey_id"];
  return GetxSurveysResultPresenter(
    surveyId: surveyId ?? "1",
    loadSurveysResult:
        makeRemoteLoadSurveyResultWithLocalFallBack(surveyId ?? ""),
  );
}
