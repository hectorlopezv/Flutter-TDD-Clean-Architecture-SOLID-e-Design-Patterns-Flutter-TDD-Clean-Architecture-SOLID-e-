import 'package:equatable/equatable.dart';

class SurveryEntity  extends Equatable{
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;
  
  List get props => [id, question, dateTime, didAnswer];

  SurveryEntity({
    required this.id,
    required this.question,
    required this.dateTime,
    required this.didAnswer,
  });
}
