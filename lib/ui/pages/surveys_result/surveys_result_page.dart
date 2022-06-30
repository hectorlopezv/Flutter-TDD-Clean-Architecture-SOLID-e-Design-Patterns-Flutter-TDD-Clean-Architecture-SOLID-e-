import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surveys_result/survey_results_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/components/reload_screen.dart';
import 'package:tdd_clean_patterns_solid/ui/components/spinner_dialog.dart';
import 'package:tdd_clean_patterns_solid/ui/components/survey_result.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';
class SurveysResultPage extends StatelessWidget {
  final SurveysResultPresenter presenter;
  const SurveysResultPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Surveys Result"),
          backgroundColor: Colors.red,
          centerTitle: true),
      body: Builder(
        builder: (context) {

              final controller = Get.put(makeGetxSurveysResultPresenter());
   

    controller.isLoadingStream.listen((isLoading) {
      if (isLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SpinnerDialog();
          },
        );
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    });
    controller.loadData();

      return StreamBuilder<SurveyResultViewModel>(
        stream: controller.surveyResultStream,
        builder: (context, snapshot) {


           if (snapshot.hasError) {
              return ReloadScreen(error: snapshot.error.toString(), reload: controller.loadData);
            }
            if (snapshot.hasData) {
              return SurveyResult(viewModel: snapshot.data!,);
            }

            return SizedBox(
              height: 10,
            );
        }
      );
        }
      ),
    );
  }
}

