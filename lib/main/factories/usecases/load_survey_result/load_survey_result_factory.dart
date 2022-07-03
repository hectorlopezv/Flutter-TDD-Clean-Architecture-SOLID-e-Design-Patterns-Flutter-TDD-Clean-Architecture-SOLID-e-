import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_survey_result.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/api_url_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/authorize_client_decorator_factory.dart';

RemoteLoadSurveysResult makeRemoteLoadSurveyResult(String? surveyId) {
  return RemoteLoadSurveysResult(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl("surveys/${surveyId}/results"));
}
