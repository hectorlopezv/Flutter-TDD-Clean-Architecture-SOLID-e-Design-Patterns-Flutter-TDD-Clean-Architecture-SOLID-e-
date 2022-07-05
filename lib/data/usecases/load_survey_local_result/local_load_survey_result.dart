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
      final data = await cacheStorage.fetch("survey_results/$surveyId");
      if (data?.isEmpty == false) {
        throw Exception();
      }

      return LocalSurveyResultModel.fromJson(data).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate(String surveyId) async {
    try {
      final data = await cacheStorage.fetch("survey_results/$surveyId");
      LocalSurveyResultModel.fromJson(data).toEntity();

    } catch (error) {
      await cacheStorage.delete("survey_results/$surveyId");
    }
  }


   Future<void> save(SurveyResultEntity surveyResult, String surveyId) async {
    try {
      final json = LocalSurveyResultModel.fromEntity(surveyResult).toJson();
      await cacheStorage.save(key: "survey_results/$surveyId", value: json);   
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
