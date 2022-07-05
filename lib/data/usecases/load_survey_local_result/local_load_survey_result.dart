import 'package:tdd_clean_patterns_solid/data/cache/cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/models/local_survey_model.dart';
import 'package:tdd_clean_patterns_solid/data/models/local_survey_result_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surveys_result.dart';

class LocalLoadSurveyResult implements LoadSurveyResult {
  final CacheStorage cacheStorage;
  LocalLoadSurveyResult({required this.cacheStorage});
  Future<SurveyResultEntity> loadBySurvey({String? surveyId}) async {
    try {
      final data = await cacheStorage.fetch("surveys");
      if (data?.isEmpty == false) {
        throw Exception();
      }

      return LocalSurveyResultModel.fromJson(data).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
