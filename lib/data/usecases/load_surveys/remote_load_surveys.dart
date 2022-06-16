


import '../../../domain/entities/survey_entity.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/load_surveys/load_surverys.dart';
import '../../http/http_client.dart';
import '../../http/http_error.dart';
import '../../models/remote_survey_model.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final HttpClientDemo<List<Map>> httpClient;
  final String url;
  @override
  Future<List<SurveryEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: "get");
      return httpResponse
          .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden? DomainError.accessDenied:DomainError.unexpected;
    }
  }

  RemoteLoadSurveys({required this.httpClient, required this.url});
}