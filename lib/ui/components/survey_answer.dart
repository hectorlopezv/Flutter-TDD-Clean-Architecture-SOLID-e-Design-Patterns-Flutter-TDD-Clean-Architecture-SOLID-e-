import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/active_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/components/disable_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_answer_viewmodel.dart';

class SurveyAnswer extends StatelessWidget {
  final SurveyAnswerViewModel viewModel;

  const SurveyAnswer({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildItems(context),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> children = [
      viewModel.image != null
          ? Image.network(
              viewModel.image!,
              width: 40,
            )
          : SizedBox(height: 0),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            viewModel.answer,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      Text(
        viewModel.percent,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark),
      ),
      viewModel.isCurretAnswer ? ActiveIcon() : DisableIcon()
    ];

    if (viewModel.image != null) {
      children.insert(0, Image.network(viewModel.image!, width: 40,));
    }
    return children;
  }
}
