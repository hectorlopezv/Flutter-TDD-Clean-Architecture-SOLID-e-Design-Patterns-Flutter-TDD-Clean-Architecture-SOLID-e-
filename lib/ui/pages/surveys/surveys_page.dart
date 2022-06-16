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
    controller.navigateTo.listen((page) {
      print("page ${page}");
      if (page.isNotEmpty == true) {
        Get.offAllNamed(page);
      }
    });

    //Error stream
    controller.mainErrorStream.listen((error) {
      if (error != null) {
        final snackBar = SnackBar(
          content: Text(
            error.toString(),
            textAlign: TextAlign.center,
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    return StreamBuilder<List<SurveyViewModel>>(
        stream: presenter.loadSurveysStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                Text("Error"),
                Text(snapshot.error.toString()),
                RaisedButton(onPressed: null, child: Text("Reload")),
              ],
            );
          }
          if (snapshot.hasData) {
            return Padding(
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
          return SizedBox(height: 0);
        });
  }
}
