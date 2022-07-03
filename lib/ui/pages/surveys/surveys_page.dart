import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surverys/surveys_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/components/reload_screen.dart';

import 'package:tdd_clean_patterns_solid/ui/components/spinner_dialog.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/components/survey_items.dart';
import 'package:tdd_clean_patterns_solid/ui/components/survey_item.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;
  const SurveysPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(makeGetxSurveysPresenter());

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
    controller.navigateToStream.listen((page) {
      Get.offNamed("/survey_result/$page");
    });

    return Scaffold(
      appBar: AppBar(
          title: Text("Surveys"),
          backgroundColor: Colors.red,
          centerTitle: true),
      body: Builder(builder: (context) {
        return StreamBuilder<List<SurveyViewModel>>(
          stream: controller.surveysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ReloadScreen(
                  error: snapshot.error.toString(),
                  reload: controller.loadData);
            }
            if (snapshot.hasData) {
              return SurveyItems(
                viewModels: snapshot.data!,
              );
            }
            return SizedBox(
              height: 10,
            );
          },
        );
      }),
    );
  }
}
