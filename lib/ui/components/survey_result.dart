import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/survey_answer.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/components/survey_header.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

class SurveyResult extends StatelessWidget {
  final void Function({required String answer}) onSave;
  final SurveyResultViewModel viewModel;
  const SurveyResult({Key? key, required this.viewModel, required this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(
            question: viewModel.question,
          );
        }
        return GestureDetector(
          onTap: () => onSave(answer: viewModel.answers[index - 1].answer),
          child: SurveyAnswer(
            viewModel: viewModel.answers[index - 1],
          ),
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
