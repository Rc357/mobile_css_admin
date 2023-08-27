enum QuestionTypeEnum {
  twoPointsCase('Two Points Case'),
  fivePointsCase('Five Points Case'),
  unknown('Unknown');

  const QuestionTypeEnum(this.description);
  final String description;
}
