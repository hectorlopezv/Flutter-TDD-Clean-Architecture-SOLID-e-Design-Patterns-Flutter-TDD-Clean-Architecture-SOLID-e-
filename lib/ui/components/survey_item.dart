import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel viewModel;
  const SurveyItem({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SurveysPresenter>();
    return GestureDetector(
      onTap: () => presenter.goToSurveyResult(viewModel.id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: viewModel.didAnswer
                  ? Theme.of(context).primaryColor
                  : Colors.green,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, 1)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text(
                viewModel.date,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                viewModel.question,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
