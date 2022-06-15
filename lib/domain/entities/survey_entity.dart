class SurveryEntity {
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;
  SurveryEntity({
    required this.id,
    required this.question,
    required this.dateTime,
    required this.didAnswer,
  });
}