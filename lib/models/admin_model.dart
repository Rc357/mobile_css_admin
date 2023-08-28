import 'package:admin/enums/admin_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  static const ID = 'id';
  static const USERNAME = 'username';
  static const EMAIL = 'email';
  static const ADMIN_TYPE = 'admin_type';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final String username;
  final String email;
  final AdminTypeEnum adminType;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminModel({
    required this.id,
    required this.username,
    required this.email,
    required this.adminType,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      USERNAME: username,
      EMAIL: email,
      ADMIN_TYPE: adminType.name,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory AdminModel.fromDocument(DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return AdminModel(
      id: map[ID] as String,
      username: map[USERNAME] as String,
      email: map[EMAIL] as String,
      adminType: AdminTypeEnum.values.byName(map[ADMIN_TYPE] as String),
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map[ID] as String,
      username: map[USERNAME] as String,
      email: map[EMAIL] as String,
      adminType: AdminTypeEnum.values.byName(map[ADMIN_TYPE] as String),
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
