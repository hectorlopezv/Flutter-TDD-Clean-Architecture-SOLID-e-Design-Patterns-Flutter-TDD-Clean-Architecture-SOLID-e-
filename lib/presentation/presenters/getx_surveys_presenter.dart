import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';
import '../../ui/helpers/errors/ui_error.dart';

class GetxSurveysPresenter extends GetxController implements SurveysPresenter {
  final LoadSurveys loadSurveys;
  final _isLoading = true.obs;
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
      _isLoading.value = true;
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
      if (_surveys.subject.isClosed == false) {
        _surveys.value = [];
        _surveys.subject.addError(UIError.unexpected.description);
      }
    } finally {
      _isLoading.value = false;
    }
  }

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  void goToSurveyResult(String surveyId) {
    _navigateTo.value = surveyId;
  }
}
