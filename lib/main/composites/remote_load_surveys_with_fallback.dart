import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/local_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';

class RemoteLoadSurveysWithLocalFallBack implements LoadSurveys {
  final RemoteLoadSurveys remote;
  final LocalLoadSurveys local;
  RemoteLoadSurveysWithLocalFallBack(
      {required this.remote, required this.local});

  @override
  Future<List<SurveryEntity>> load() async {
    try {
      final surveys = await remote.load();
      await local.save(surveys);
      return surveys;
    } catch (error) {
      if (error == DomainError.accessDenied) {
        rethrow;
      }
      await local.validate();
      return await local.load();
    }
  }
}
