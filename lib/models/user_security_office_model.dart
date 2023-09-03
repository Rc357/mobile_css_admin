import 'package:admin/enums/type_user_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSecurityOfficeModel {
  static const UID = 'uid';
  static const NAME = 'name';
  static const ADDRESS = 'address';
  static const USER_TYPE = 'userType';
  static const ANSWERED = 'answered';
  static const VERSION = 'version';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String uid;
  final String name;
  final String address;
  final UserTypeEnum userType;
  final bool answered;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserSecurityOfficeModel({
    required this.uid,
    required this.name,
    required this.address,
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
      ADDRESS: address,
      USER_TYPE: userType.name,
      ANSWERED: answered,
      VERSION: version,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory UserSecurityOfficeModel.fromMap(Map<String, dynamic> map) {
    return UserSecurityOfficeModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      address: map[ADDRESS] as String,
      userType: UserTypeEnum.values.byName(map[USER_TYPE] as String),
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }

  factory UserSecurityOfficeModel.fromDocument(
      DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return UserSecurityOfficeModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      address: map[ADDRESS] as String,
      userType: map[USER_TYPE] as UserTypeEnum,
      answered: map[ANSWERED] as bool,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
