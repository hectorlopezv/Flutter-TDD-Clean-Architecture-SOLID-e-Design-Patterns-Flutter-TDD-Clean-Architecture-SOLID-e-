import 'package:tdd_clean_patterns_solid/data/models/local_survey_answer_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';

class LocalSurveyResultModel {
  final String surveyId;
  final String question;
  final List<LocalSurveyAnswerModel> answers;

  LocalSurveyResultModel(
      {required this.surveyId, required this.question, required this.answers});

  factory LocalSurveyResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(["surveyId", "question", "answers"])) {
      throw Exception();
    }

    return LocalSurveyResultModel(
      surveyId: json["id"],
      question: json["question"],
      answers: json["answers"]
          .map<LocalSurveyAnswerModel>(
              (answerJson) => LocalSurveyAnswerModel.fromJson(answerJson))
          .toList(),
    );
  }

  factory LocalSurveyResultModel.fromEntity(SurveyResultEntity entity) {
    return LocalSurveyResultModel(
        surveyId: entity.surveyId,
        question: entity.question,
        answers: entity.answers
            .map<LocalSurveyAnswerModel>((answer) => LocalSurveyAnswerModel.fromEntity(answer))
            .toList());
  }

  SurveyResultEntity toEntity() => SurveyResultEntity(
      surveyId: surveyId,
      question: question,
      answers: answers
          .map<SurveyAnswerEntity>((answer) => answer.toEntity())
          .toList());

  Map toJson() => {
        "surveyId": surveyId,
        "question": question,
        "answers": answers.map<Map>((answer) => answer.toJson()).toList(),
      };
  
}
