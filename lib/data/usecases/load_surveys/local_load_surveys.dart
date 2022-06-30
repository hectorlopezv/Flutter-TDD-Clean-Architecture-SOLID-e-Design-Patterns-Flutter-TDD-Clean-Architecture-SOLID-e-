import 'package:tdd_clean_patterns_solid/data/cache/cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/models/local_survey_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';

class LocalLoadSurveys implements LoadSurveys {
  final CacheStorage cacheStorage;
  LocalLoadSurveys({required this.cacheStorage});
  Future<List<SurveryEntity>> load() async {
    try {
      final data = await cacheStorage.fetch("surveys");
      if (data?.isEmpty == false) {
        throw Exception();
      }

      return _mapToEntity(data);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      final data = await cacheStorage.fetch("surveys");
      _mapToEntity(data);
    } catch (error) {
      await cacheStorage.delete("surveys");
    }
  }

  Future<void> save(List<SurveryEntity> surveys) async {
    try {
      await cacheStorage.save(key: "surveys", value: _mapToJson(surveys));   
    } catch (error) {
      throw DomainError.unexpected;
    }
   
  }

  List<Map> _mapToJson(List<SurveryEntity> list) => list
      .map((entity) => LocalSurveyModel.fromEntity(entity).toJson())
      .toList();
  List<SurveryEntity> _mapToEntity(List<Map> list) => list
      .map<SurveryEntity>((json) => LocalSurveyModel.fromJson(json).toEntity())
      .toList();
}
