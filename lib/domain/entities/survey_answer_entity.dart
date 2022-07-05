import 'package:equatable/equatable.dart';

class SurveyAnswerEntity extends Equatable {
  final String answer;
  final bool isCurrentAnswer;
  final int percent;
  final String? image;

  List get props => [answer, isCurrentAnswer, percent, image];

  SurveyAnswerEntity({
    this.image,
    required this.percent,
    required this.answer,
    required this.isCurrentAnswer,
  });
}
