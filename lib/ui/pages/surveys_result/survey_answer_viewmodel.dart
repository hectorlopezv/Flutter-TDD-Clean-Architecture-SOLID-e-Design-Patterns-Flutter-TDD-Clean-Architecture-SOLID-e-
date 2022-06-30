import 'package:equatable/equatable.dart';

class SurveyAnswerViewModel extends Equatable {
  final String? image;
  final String answer;
  final bool isCurretAnswer;
  final String percent;


  List get props => [image, answer, isCurretAnswer, percent];

  SurveyAnswerViewModel({
     this.image,
    required this.answer,
    required this.isCurretAnswer,
    required this.percent,
  });

}
