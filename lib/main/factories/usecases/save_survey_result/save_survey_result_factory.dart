import 'package:tdd_clean_patterns_solid/data/usecases/save_survey_result/remote_save_survey_result.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_survey_result/save_survey_result.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/api_url_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/authorize_client_decorator_factory.dart';

SaveSurveyResult makeRemoteSaveSurveyResult(String surveyId) {
  return RemoteSaveSurveysResult(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl("surveys/${surveyId}/results"));
}


