import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/data/models/remote_survey_result_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surveys_result.dart';

class RemoteLoadSurveysResult implements LoadSurveyResult {
  final HttpClientDemo<dynamic> httpClient;
  final String url;

  Future<SurveyResultEntity> loadBySurvey({String? surveyId}) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: "get");
      return RemoteSurveyResultModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }

  RemoteLoadSurveysResult({required this.httpClient, required this.url});
}
