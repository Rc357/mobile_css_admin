import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionnaireVersionModel {
  static const ID = 'id';
  static const QUESTIONNAIRE_VERSION = 'questionnaireVersion';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final int questionnaireVersion;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionnaireVersionModel({
    required this.id,
    required this.questionnaireVersion,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      QUESTIONNAIRE_VERSION: questionnaireVersion,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory QuestionnaireVersionModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaireVersionModel(
      id: map[ID] as String,
      questionnaireVersion: map[QUESTIONNAIRE_VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }

  factory QuestionnaireVersionModel.fromDocument(
      DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return QuestionnaireVersionModel(
      id: map[ID] as String,
      questionnaireVersion: map[QUESTIONNAIRE_VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
