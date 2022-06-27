import '../../../domain/entities/survey_entity.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/load_surveys/load_surverys.dart';
import '../../http/http_client.dart';
import '../../http/http_error.dart';
import '../../models/remote_survey_model.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final HttpClientDemo<dynamic> httpClient;
  final String url;
  @override
  Future<List<SurveryEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: "get");
       final List<SurveryEntity> surveys = httpResponse
          .map<SurveryEntity>((json) => RemoteSurveyModel.fromJson(json).toEntity()).toList();
      return surveys;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }

  RemoteLoadSurveys({required this.httpClient, required this.url});
}
