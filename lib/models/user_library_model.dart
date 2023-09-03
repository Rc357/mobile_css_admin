import 'package:admin/enums/course_enum.dart';
import 'package:admin/enums/gender_enum.dart';
import 'package:admin/enums/type_user_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserLibraryModel {
  static const UID = 'uid';
  static const NAME = 'name';
  static const CONTACT = 'contact';
  static const COURSE = 'course';
  static const GENDER = 'gender';
  static const USER_TYPE = 'userType';
  static const ANSWERED = 'answered';
  static const VERSION = 'version';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String uid;
  final String name;
  final String contact;
  final CourseEnum course;
  final GenderEnum gender;
  final UserTypeEnum userType;
  final bool answered;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserLibraryModel({
    required this.uid,
    required this.name,
    required this.contact,
    required this.gender,
    required this.course,
    required this.userType,
    required this.answered,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      UID: uid,
      NAME: name,
      CONTACT: contact,
      COURSE: course.name,
      GENDER: gender.name,
      USER_TYPE: userType.name,
      ANSWERED: answered,
      VERSION: version,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory UserLibraryModel.fromMap(Map<String, dynamic> map) {
    return UserLibraryModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      contact: map[CONTACT] as String,
      gender: GenderEnum.values.byName(map[GENDER] as String),
      course: CourseEnum.values.byName(map[COURSE] as String),
      userType: UserTypeEnum.values.byName(map[USER_TYPE] as String),
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }

  factory UserLibraryModel.fromDocument(DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return UserLibraryModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      contact: map[CONTACT] as String,
      gender: GenderEnum.values.byName(map[GENDER] as String),
      course: CourseEnum.values.byName(map[COURSE] as String),
      userType: UserTypeEnum.values.byName(map[USER_TYPE] as String),
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
