import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

class SurveyHeader extends StatelessWidget {
  final String question;
  const SurveyHeader({
    Key? key,
    required this.question,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
      child: Text(question),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
    );
  }
}
