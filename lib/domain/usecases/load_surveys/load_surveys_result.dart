import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';

abstract class LoadSurveyResult {
  Future<SurveyResultEntity> loadBySurvey( {String? surveyId});
}
