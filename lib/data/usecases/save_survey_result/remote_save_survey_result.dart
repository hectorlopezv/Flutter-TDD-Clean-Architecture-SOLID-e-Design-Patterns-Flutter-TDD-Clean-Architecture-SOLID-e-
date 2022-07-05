import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/data/models/remote_survey_result_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/save_survey_result/save_survey_result.dart';

class RemoteSaveSurveysResult implements SaveSurveyResult {
  final HttpClientDemo<dynamic> httpClient;
  final String url;

  RemoteSaveSurveysResult({required this.httpClient, required this.url});

  Future<SurveyResultEntity> save({required String answer}) async {
    try {
      final json = await httpClient
          .request(url: url, method: "put", body: {"answer": answer});

      return RemoteSurveyResultModel.fromJson(json).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
