import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/active_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/components/disable_icon.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;
  const SurveyResult({
    Key? key,
    required this.viewModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            child: Text(viewModel.question),
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   viewModel.answers[index - 1].image != null ?
                    Image.network(
                    viewModel.answers[index - 1].image!,
                    width: 40,
                  ) : SizedBox(height: 0),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        viewModel.answers[index - 1].answer,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Text(
                    viewModel.answers[index - 1].percent,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                   viewModel.answers[index - 1].isCurretAnswer? ActiveIcon() : DisableIcon()
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}

