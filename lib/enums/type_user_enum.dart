enum UserTypeEnum {
  student('Student'),
  alumni('Alumni'),
  parents('Parents'),
  guest('Guest'),
  unknown('Unknown');

  const UserTypeEnum(this.description);
  final String description;
}
