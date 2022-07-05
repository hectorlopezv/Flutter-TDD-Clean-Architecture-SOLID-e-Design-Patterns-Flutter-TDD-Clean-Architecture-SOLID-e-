import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';

class RemoteSurveyAnswerModel {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;

  RemoteSurveyAnswerModel(
      { this.image,
      required this.answer,
      required this.isCurrentAnswer,
      required this.percent});

  factory RemoteSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(["answer", "isCurrentAccountAnswer", "percent"])) {
      throw HttpError.invalidData;
    }

    return RemoteSurveyAnswerModel(
      image: json["image"],
      answer: json["answer"],
      percent: json["percent"],
      isCurrentAnswer: json["isCurrentAccountAnswer"],
    );
  }

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
      image: image,
      answer: answer,
      isCurrentAnswer: isCurrentAnswer,
      percent: percent);
}
