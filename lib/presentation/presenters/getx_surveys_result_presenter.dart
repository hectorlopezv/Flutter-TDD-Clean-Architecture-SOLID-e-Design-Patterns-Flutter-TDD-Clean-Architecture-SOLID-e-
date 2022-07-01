import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_viewmodel.dart';
class GetxSurveysResultPresenter extends GetxController implements SurveysResultPresenter {

  final _isLoading = true.obs;

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

    } on DomainError catch (error) {

    } finally {
      _isLoading.value = false;
    }
  }

  GetxSurveysResultPresenter({});

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;


  @override
  Stream<SurveyResultViewModel> get surveyResultStream => ;
}
