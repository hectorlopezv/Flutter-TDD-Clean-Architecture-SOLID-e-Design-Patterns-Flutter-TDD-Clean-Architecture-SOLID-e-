

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tdd_clean_patterns_solid/domain/helpers/helpers.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys_result/survey_result_presenter.dart';
import 'package:get/get.dart';
class GetxSurveysResultPresenter extends GetxController implements SurveysResultPresenter {
  final LoadSurveys loadSurveys;
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

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;
}
