enum GenderEnum {
  male('Male'),
  female('Female'),
  other('Other'),
  unknown('Unknown');

  const GenderEnum(this.description);
  final String description;
}
