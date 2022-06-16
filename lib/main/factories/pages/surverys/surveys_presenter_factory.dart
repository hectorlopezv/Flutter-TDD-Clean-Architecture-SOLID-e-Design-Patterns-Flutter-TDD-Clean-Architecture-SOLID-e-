import 'package:tdd_clean_patterns_solid/main/factories/usecases/addAccount/add_account_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_signin_presenter.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import '../../usecases/saveCurrentAccount/save_current_account_factory.dart';
import '../login/login_validation_factory.dart';

SurveysPresenter makeGetxSurveysPresenter() {
  return GetxSurveysPresenter();
}
