import 'package:equatable/equatable.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_entity.dart';

class RemoteSurveyModel extends Equatable {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;
  
  List get props => [id, question, date, didAnswer];

  RemoteSurveyModel(
      {required this.id,
      required this.question,
      required this.date,
      required this.didAnswer});

  factory RemoteSurveyModel.fromJson(Map json) {
    if(!json.keys.toSet().containsAll(["id", "question", "date", "didAnswer"])) {
      throw HttpError.invalidData;
    }
      
    return RemoteSurveyModel(
      id: json["id"],
      question: json["question"],
      date: json["date"],
      didAnswer: json["didAnswer"],
    );
  }

  SurveryEntity toEntity() => SurveryEntity(
      id: id, question: question, dateTime: DateTime.parse(date), didAnswer: didAnswer);
}
