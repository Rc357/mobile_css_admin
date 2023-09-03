enum CourseEnum {
  bsElementaryEducation('Bachelor of Elementary Education'),
  bsEducationEnglishMath('Bachelor of Secondary Education (English & Math)'),
  bsAutomotiveTechnology('Bachelor of Science in Automotive Technology'),
  bsComputerEngineering('Bachelor of Science in Computer Engineering'),
  bsElectricalTechnology('Bachelor of Science in Electrical Technology'),
  bsElectronicsEngineering('Bachelor of Science in Electronics Engineering'),
  bsElectronicsTechnology('Bachelor of Science in Electronics Technology'),
  bsEntrepreneurship('Bachelor of Science in Entrepreneurship'),
  bsFoodTechnology('Bachelor of Science in Food Technology'),
  bsInformationSystem('Bachelor of Science in Information System'),
  bsInformationTechnology('Bachelor of Science in Information Technology'),
  bsInformationTechnologyAnimation(
      'Bachelor of Science in Information Technology (Animation)'),
  bsMechanicalTechnology('Bachelor of Science in Mechanical Technology'),
  bsNursing('Bachelor of Science in Nursing'),
  bTechnologyLivelihoodEducation(
      'Bachelor of Technology and Livelihood Education (BTLEd)'),
  unknown('Unknown');

  const CourseEnum(this.description);
  final String description;
}
