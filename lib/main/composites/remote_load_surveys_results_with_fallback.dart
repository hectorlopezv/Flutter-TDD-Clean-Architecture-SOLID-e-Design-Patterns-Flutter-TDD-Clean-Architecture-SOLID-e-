import 'package:tdd_clean_patterns_solid/data/usecases/load_survey_local_result/local_load_survey_result.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surveys_result.dart';

class RemoteLoadSurveyResultWithLocalFallBack implements LoadSurveyResult {
  final LoadSurveyResult remote;
  final LocalLoadSurveyResult local;
  RemoteLoadSurveyResultWithLocalFallBack(
      {required this.remote, required this.local});

  @override
  Future<SurveyResultEntity> loadBySurvey({String? surveyId}) async {
    try {
      final surveyResult = await remote.loadBySurvey(surveyId: surveyId);
      await local.save(surveyResult, surveyId ?? "");
      return surveyResult;
    } catch (error) {
      if (error == DomainError.accessDenied) {
        rethrow;
      }
      await local.validate(surveyId ?? "");
      return await local.loadBySurvey(surveyId: surveyId);
    }
  }
}
