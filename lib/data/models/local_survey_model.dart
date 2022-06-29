import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';

class LocalSurveyModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  LocalSurveyModel(
      {required this.id,
      required this.question,
      required this.date,
      required this.didAnswer});

  factory LocalSurveyModel.fromJson(Map json) {
    if(!json.keys.toSet().containsAll(["id", "question", "date", "didAnswer"])) {
      throw HttpError.invalidData;
    }
      
    return LocalSurveyModel(
      id: json["id"],
      question: json["question"],
      date: DateTime.parse(json["date"]).toIso8601String(),
      didAnswer: bool.fromEnvironment(json["didAnswer"]),
    );
  }

  SurveryEntity toEntity() => SurveryEntity(
      id: id, question: question, dateTime: DateTime.parse(date), didAnswer: didAnswer);
}
