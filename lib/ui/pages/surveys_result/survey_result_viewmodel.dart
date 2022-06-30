


import 'package:equatable/equatable.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_answer_viewmodel.dart';

class SurveyResultViewModel extends Equatable {
  final String surveyId;
  final String question;
  final List<SurveyAnswerViewModel> answers;

  List get props => [surveyId, question, answers];

  SurveyResultViewModel({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}
