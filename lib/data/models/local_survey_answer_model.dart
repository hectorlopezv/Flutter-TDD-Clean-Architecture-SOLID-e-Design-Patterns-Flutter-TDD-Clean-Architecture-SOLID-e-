import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';

class LocalSurveyAnswerModel {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;

  LocalSurveyAnswerModel(
      {this.image,
      required this.answer,
      required this.isCurrentAnswer,
      required this.percent});

  factory LocalSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(["answer", "isCurrentAnswer", "percent"])) {
      throw Exception();
    }

    return LocalSurveyAnswerModel(
      image: json["image"],
      answer: json["answer"],
      isCurrentAnswer: bool.fromEnvironment(json["isCurrentAnswer"]),
      percent: int.parse(json["percent"]),
    );
  }

  factory LocalSurveyAnswerModel.fromEntity(SurveyAnswerEntity entity) {
    return LocalSurveyAnswerModel(
        image: entity.image,
        answer: entity.answer,
        isCurrentAnswer: entity.isCurrentAnswer,
        percent: entity.percent);
  }

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
        image: image,
        answer: answer,
        isCurrentAnswer: isCurrentAnswer,
        percent: percent,
      );

  Map<String, String> toJson() => {
        "image": image ?? "",
        "isCurrentAnswer": isCurrentAnswer.toString(),
        "percent": percent.toString()
      };
}
