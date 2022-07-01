import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/active_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/components/disable_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/components/survey_answer.dart';
import 'package:tdd_clean_patterns_solid/ui/components/survey_header.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_answer_viewmodel.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;
  const SurveyResult({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(
            question: viewModel.question,
          );
        }

        return SurveyAnswer(viewModel: viewModel.answers[index -1],);
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
