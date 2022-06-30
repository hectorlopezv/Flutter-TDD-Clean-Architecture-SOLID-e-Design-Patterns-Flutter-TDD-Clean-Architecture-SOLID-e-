import 'package:equatable/equatable.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';

class SurveyResultEntity extends Equatable {
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;

  List get props => [surveyId, question, answers];

  SurveyResultEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}
