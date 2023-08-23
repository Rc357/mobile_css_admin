import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyLibraryModel {
  static const ID = 'id';
  static const USER_ID = 'user_id';
  static const QUESTION1 = 'question1';
  static const QUESTION2 = 'question2';
  static const QUESTION3 = 'question3';
  static const QUESTION4 = 'question4';
  static const REMARKS = 'remarks';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final String userId;
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  SurveyLibraryModel({
    required this.id,
    required this.userId,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      USER_ID: userId,
      QUESTION1: question1,
      QUESTION2: question2,
      QUESTION3: question3,
      QUESTION4: question4,
      REMARKS: remarks,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory SurveyLibraryModel.fromMap(Map<String, dynamic> map) {
    return SurveyLibraryModel(
      id: map[ID] as String,
      userId: map[USER_ID] as String,
      question1: map[QUESTION1] as String,
      question2: map[QUESTION2] as String,
      question3: map[QUESTION3] as String,
      question4: map[QUESTION4] as String,
      remarks: map[REMARKS] as String,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
