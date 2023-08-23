import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const UID = 'uid';
  static const NAME = 'name';
  static const CONTACT = 'contact';
  static const USER_TYPE = 'userType';
  static const ANSWERED = 'answered';
  static const SERVICE = 'service';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String uid;
  final String name;
  final String contact;
  final String userType;
  final bool answered;
  final String service;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.contact,
    required this.userType,
    required this.answered,
    required this.service,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      UID: uid,
      NAME: name,
      CONTACT: contact,
      USER_TYPE: userType,
      ANSWERED: answered,
      SERVICE: service,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: map[UID] as String,
      name: map[NAME] as String,
      contact: map[CONTACT] as String,
      userType: map[USER_TYPE] as String,
      answered: map[ANSWERED] as bool,
      service: map[SERVICE] as String,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
