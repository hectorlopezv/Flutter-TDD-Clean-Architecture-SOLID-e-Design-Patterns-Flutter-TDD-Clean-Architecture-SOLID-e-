import 'package:equatable/equatable.dart';

class SurveyViewModel extends Equatable {
  final String id;
  final String question;
  final bool didAnswer;
  final String date;
  List get props =>[id, question, didAnswer, date];

  SurveyViewModel({
   required this.id,
    required this.question,
   required this.didAnswer,
    required this.date,
  });
}
