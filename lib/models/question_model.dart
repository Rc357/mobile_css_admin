import 'package:admin/enums/question_type_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  static const ID = 'questionId';
  static const QUESTION_NUMBER = 'questionNumber';
  static const QUESTION = 'question';
  static const YES = 'yes';
  static const NO = 'no';
  static const EXCELlENT = 'excellent';
  static const VERY_SATISFACTORY = 'verySatisfactory';
  static const SATISFACTORY = 'satisfactory';
  static const FAIR = 'fair';
  static const POOR = 'poor';
  static const TYPE = 'type';
  static const VERSION = 'version';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final String question;
  final int questionNumber;
  final QuestionTypeEnum type;
  final int yes;
  final int no;
  final int excellent;
  final int verySatisfactory;
  final int satisfactory;
  final int fair;
  final int poor;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionModel({
    required this.id,
    required this.question,
    required this.questionNumber,
    required this.type,
    required this.yes,
    required this.no,
    required this.excellent,
    required this.verySatisfactory,
    required this.satisfactory,
    required this.fair,
    required this.poor,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      QUESTION: question,
      QUESTION_NUMBER: questionNumber,
      TYPE: type.name,
      YES: yes,
      NO: no,
      EXCELlENT: excellent,
      VERY_SATISFACTORY: verySatisfactory,
      SATISFACTORY: satisfactory,
      FAIR: fair,
      POOR: poor,
      VERSION: version,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map[ID] as String,
      question: map[QUESTION] as String,
      questionNumber: map[QUESTION_NUMBER] as int,
      type: QuestionTypeEnum.values.byName(map[TYPE] as String),
      yes: map[YES] as int,
      no: map[NO] as int,
      excellent: map[EXCELlENT] as int,
      verySatisfactory: map[VERY_SATISFACTORY] as int,
      satisfactory: map[SATISFACTORY] as int,
      fair: map[FAIR] as int,
      poor: map[POOR] as int,
      version: map[VERSION] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
