import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';
import 'package:tdd_clean_patterns_solid/presentation/mixins/loading_manager.dart';
import 'package:tdd_clean_patterns_solid/presentation/mixins/session_manager.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';
import '../../ui/helpers/errors/ui_error.dart';

class GetxSurveysPresenter extends GetxController
    with SessionManager, LoadingManager
    implements SurveysPresenter {
  final LoadSurveys loadSurveys;

  final _navigateTo = Rx<String>("");
  final _surveys = Rx<List<SurveyViewModel>>([]);

  @override
  onInit() async {
    super.onInit();
    await loadData();
  }

  @override
  Future<void> loadData() async {
    try {
      isLoading = true;
      sessionExpired = false;
      final surveys = await loadSurveys.load();
      _surveys.value = surveys
          .map((survey) => SurveyViewModel(
                date: DateFormat("dd MM yyyy").format(survey.dateTime),
                didAnswer: survey.didAnswer,
                id: survey.id,
                question: survey.question,
              ))
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        sessionExpired = true;
      } else {
        _surveys.value = [];
        _surveys.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  void goToSurveyResult(String surveyId) {
    _navigateTo.value = surveyId;
  }
}
