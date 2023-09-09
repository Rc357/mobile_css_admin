import 'package:admin/enums/course_enum.dart';
import 'package:admin/enums/type_user_enum.dart';
import 'package:admin/enums/year_level_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCashierModel {
  static const UID = 'uid';
  static const NAME = 'name';
  static const COURSE = 'course';
  static const YEAR_LEVEL = 'yearLevel';
  static const USER_TYPE = 'userType';
  static const ANSWERED = 'answered';
  static const VERSION = 'version';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String uid;
  final String name;
  final CourseEnum course;
  final YearLevelEnum yearLevel;
  final UserTypeEnum userType;
  final bool answered;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserCashierModel({
    required this.uid,
    required this.name,
    required this.course,
    required this.yearLevel,
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
      COURSE: course.name,
      YEAR_LEVEL: yearLevel.name,
      USER_TYPE: userType.name,
      ANSWERED: answered,
      VERSION: version,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory UserCashierModel.fromMap(Map<String, dynamic> map) {
    return UserCashierModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      course: CourseEnum.values.byName(map[COURSE] as String),
      yearLevel: YearLevelEnum.values.byName(map[YEAR_LEVEL] as String),
      userType: UserTypeEnum.values.byName(map[USER_TYPE] as String),
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }

  factory UserCashierModel.fromDocument(DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return UserCashierModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      course: CourseEnum.values.byName(map[COURSE] as String),
      yearLevel: YearLevelEnum.values.byName(map[YEAR_LEVEL] as String),
      userType: UserTypeEnum.values.byName(map[USER_TYPE] as String),
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
