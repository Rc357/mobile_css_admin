import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyRemarksModel {
  static const ID = 'id';
  static const REMARKS = 'remarks';
  static const REFERENCE_USER = 'referenceUser';
  static const OFFICE_NAME = 'officeName';
  static const VERSION = 'version';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final String remarks;
  final String referenceUser;
  final String officeName;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  SurveyRemarksModel({
    required this.id,
    required this.remarks,
    required this.referenceUser,
    required this.officeName,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      REMARKS: remarks,
      REFERENCE_USER: referenceUser,
      OFFICE_NAME: officeName,
      VERSION: version,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory SurveyRemarksModel.fromMap(Map<String, dynamic> map) {
    return SurveyRemarksModel(
      id: map[ID] as String,
      remarks: map[REMARKS] as String,
      referenceUser: map[REFERENCE_USER] as String,
      officeName: map[OFFICE_NAME] as String,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
