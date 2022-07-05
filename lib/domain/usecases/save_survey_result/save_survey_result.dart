
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';

abstract class SaveSurveyResult {
  Future<SurveyResultEntity> save({required String surveyId});
}