import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surverys/surveys_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/components/spinner_dialog.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/components/survey_item.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;
  const SurveysPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(makeGetxSurveysPresenter());
    controller.loadData();

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

    return StreamBuilder<List<SurveyViewModel>>(
        stream: controller.surveysStream,
        builder: (context, snapshot) {
          Widget error = SizedBox(
            height: 0,
          );
          Widget data = SizedBox(
            height: 0,
          );
          if (snapshot.hasError || !snapshot.hasData) {
            error = Column(
              children: [
                Text("Error"),
                Text(snapshot.error.toString()),
                RaisedButton(
                    onPressed: presenter.loadData, child: Text("Reload")),
              ],
            );
          }
          if (snapshot.hasData) {
            data = Padding(
              padding: EdgeInsets.all(20),
              child: CarouselSlider(
                items: snapshot.data
                    ?.map((viewModel) => SurveyItem(
                          viewModel: viewModel,
                        ))
                    .toList(),
                options:
                    CarouselOptions(aspectRatio: 1, enlargeCenterPage: true),
              ),
            );
          } 

          return Scaffold(
            appBar: AppBar(
              
                title: Text("Surveys"),
                backgroundColor: Colors.red,
                centerTitle: true),
                 body: Center(child: Padding(padding:EdgeInsets.all(40),child: Column(children: [error, data], mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,))),
          );
        });
  }
}
