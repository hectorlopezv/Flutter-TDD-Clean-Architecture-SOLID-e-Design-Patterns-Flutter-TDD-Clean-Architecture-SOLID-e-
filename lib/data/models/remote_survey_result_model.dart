import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import 'package:tdd_clean_patterns_solid/data/models/remote_survey_answer_model.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';

class RemoteSurveyResultModel {
  final String surveyId;
  final String question;
  final List<RemoteSurveyAnswerModel> answers;

  List get props => [surveyId, question, answers];

  RemoteSurveyResultModel(
      {required this.surveyId, required this.question, required this.answers});

  factory RemoteSurveyResultModel.fromJson(Map json) {
    final valid = json.keys
        .toSet()
        .containsAll({"surveyId", "question", "answers"});
    if (!valid) {
      throw HttpError.invalidData;
    }

    return RemoteSurveyResultModel(
      surveyId: json["surveyId"],
      question: json["question"],
      answers: json["answers"]
          .map<RemoteSurveyAnswerModel>(
              (answerJson) => RemoteSurveyAnswerModel.fromJson(answerJson))
          .toList(),
    );
  }

  SurveyResultEntity toEntity() => SurveyResultEntity(
      surveyId: surveyId,
      question: question,
      answers: answers
          .map<SurveyAnswerEntity>((answer) => answer.toEntity())
          .toList());
}
