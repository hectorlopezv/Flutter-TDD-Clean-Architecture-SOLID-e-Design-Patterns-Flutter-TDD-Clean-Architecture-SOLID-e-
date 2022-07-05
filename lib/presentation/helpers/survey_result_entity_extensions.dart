
import 'package:tdd_clean_patterns_solid/domain/entities/survey_answer_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/survey_result_entity.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_answer_viewmodel.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';



//only available in this file or file that import this one.
extension SurveyResulyEntityExtension on SurveyResultEntity {
  SurveyResultViewModel toViewModel() {
    return SurveyResultViewModel(
      answers: answers
          .map(
            (answer) => answer.toViewModel(),
          )
          .toList(),
      question: question,
      surveyId: surveyId,
    );
  }
}

extension SurveyAnswerEntityExtension on SurveyAnswerEntity {
  SurveyAnswerViewModel toViewModel() {
    return SurveyAnswerViewModel(
      answer: answer,
      isCurretAnswer: isCurrentAnswer,
      percent: "${percent}%",
      image: image,
    );
  }
}