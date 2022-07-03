import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surveys_result.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_answer_viewmodel.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';

class GetxSurveysResultPresenter extends GetxController
    implements SurveysResultPresenter {
  final LoadSurveyResult loadSurveysResult;
  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel?>(null);
  final String surveyId;

  GetxSurveysResultPresenter(
      {required this.loadSurveysResult, required this.surveyId});

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<SurveyResultViewModel?> get surveyResultStream => _surveyResult.stream;

  @override
  onInit() async {
    super.onInit();
    await loadData();
  }

  @override
  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      final surveyResult =
          await loadSurveysResult.loadBySurvey(surveyId: surveyId);
      _surveyResult.value = SurveyResultViewModel(
        answers: surveyResult.answers
            .map(
              (answer) => SurveyAnswerViewModel(
                  answer: answer.answer,
                  isCurretAnswer: answer.isCurrentAccountAnswer,
                  percent: "${answer.percent}%",
                  image: answer.image),
            )
            .toList(),
        question: surveyResult.question,
        surveyId: surveyResult.surveyId,
      );
    } on DomainError catch (error) {
      if (_surveyResult.subject.isClosed == false) {
        _surveyResult.value = null;
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } catch (error) {
      print(error);
    } finally {
      _isLoading.value = false;
    }
  }
}
