import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/surverys/surveys_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/ui/components/reload_screen.dart';
import 'package:tdd_clean_patterns_solid/ui/components/spinner_dialog.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/components/survey_items.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

class SurveysPage extends StatefulWidget {
  final SurveysPresenter presenter;
  const SurveysPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<SurveysPage> createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> with RouteAware {
  @override
  void dispose() {
    final routeObserver = Get.find<RouteObserver>();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    final controller = Get.put(makeGetxSurveysPresenter());
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final routeObserver = Get.find<RouteObserver>();
    routeObserver.subscribe(
      this,
      ModalRoute.of(context)!,
    );
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
      } else if (isLoading == false) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    });

    controller.isSessionExpiredStream.listen((isSessionExpired) {
      if (isSessionExpired) {
        Get.offAllNamed("/login");
      }
    });

    controller.navigateToStream.listen((page) {
      Navigator.of(context).pushNamed("/survey_result/$page");
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
