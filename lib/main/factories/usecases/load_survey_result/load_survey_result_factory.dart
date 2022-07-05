import 'package:tdd_clean_patterns_solid/data/usecases/load_survey_local_result/local_load_survey_result.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_survey_result.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surveys_result.dart';
import 'package:tdd_clean_patterns_solid/main/composites/remote_load_surveys_results_with_fallback.dart';
import 'package:tdd_clean_patterns_solid/main/factories/cache/local_storage_adapter_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/api_url_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/authorize_client_decorator_factory.dart';

LoadSurveyResult makeRemoteLoadSurveyResult(String surveyId) {
  return RemoteLoadSurveysResult(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl("surveys/${surveyId}/results"));
}

LocalLoadSurveyResult makeLocalLoadSurveyResult(String surveyId) {
  return LocalLoadSurveyResult(cacheStorage: makeLocalStorageAdapter());
}

LoadSurveyResult makeRemoteLoadSurveyResultWithLocalFallBack(String surveyId) {
  return RemoteLoadSurveyResultWithLocalFallBack(
    remote: makeRemoteLoadSurveyResult(surveyId),
    local: makeLocalLoadSurveyResult(surveyId),
  );
}
