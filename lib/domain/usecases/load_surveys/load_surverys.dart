


import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';

abstract class LoadSurveys {
  Future<List<SurveryEntity>> load();
}

