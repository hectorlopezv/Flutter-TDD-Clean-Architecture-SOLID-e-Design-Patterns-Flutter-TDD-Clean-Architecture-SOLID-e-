


import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/surveys/surveys_view_model.dart';

import '../../ui/helpers/errors/ui_error.dart';

class GetxSurveysPresenter extends GetxController implements SurveysPresenter {

  var isFormValid = false.obs;
  var isLoading = false.obs;
  var navigateTo = "".obs;
  var mainError = Rx<UIError?>(null);

  Stream<String> get navigateToStream => navigateTo.stream;
  Stream<UIError?> get mainErrorStream => mainError.stream;
  Stream<bool> get isFormValidStream => isFormValid.stream;
  Stream<bool> get isLoadingStream => isLoading.stream;
  @override
  Future<void> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  Stream<List<SurveyViewModel>> get loadSurveysStream => ;

 
 
}
