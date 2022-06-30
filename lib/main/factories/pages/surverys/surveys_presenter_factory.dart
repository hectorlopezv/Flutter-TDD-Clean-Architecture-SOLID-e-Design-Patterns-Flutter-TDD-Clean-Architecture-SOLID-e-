import 'package:tdd_clean_patterns_solid/main/factories/usecases/load_surveys/load_surveys_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';

SurveysPresenter makeGetxSurveysPresenter() {
  return GetxSurveysPresenter(loadSurveys: makeRemoteLoadSurveysWithLocalFallBack());
}
