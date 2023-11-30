class QuestionAverage {
  final String question;
  final double average;
  final int totalUser;

  QuestionAverage({
    required this.question,
    required this.average,
    required this.totalUser,
  });
}

class QuestionTotalTwoPoints {
  final String question;
  final int totalYes;
  final int totalNo;
  final int totalUser;

  QuestionTotalTwoPoints({
    required this.question,
    required this.totalYes,
    required this.totalNo,
    required this.totalUser,
  });
}
