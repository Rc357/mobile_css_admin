import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  static const ID = 'questionId';
  static const QUESTION_NUMBER = 'questionNumber';
  static const QUESTION = 'question';
  static const AGREE = 'agree';
  static const DISAGREE = 'disagree';
  static const EXCELlENT = 'excellent';
  static const VERY_SATISFACTORY = 'verySatisfactory';
  static const SATISFACTORY = 'satisfactory';
  static const FAIR = 'fair';
  static const POOR = 'poor';
  static const TYPE = 'type';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String id;
  final String question;
  final int questionNumber;
  final String type;
  final int agree;
  final int disagree;
  final int excellent;
  final int verySatisfactory;
  final int satisfactory;
  final int fair;
  final int poor;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionModel({
    required this.id,
    required this.question,
    required this.questionNumber,
    required this.type,
    required this.agree,
    required this.disagree,
    required this.excellent,
    required this.verySatisfactory,
    required this.satisfactory,
    required this.fair,
    required this.poor,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      QUESTION: question,
      QUESTION_NUMBER: questionNumber,
      TYPE: type,
      AGREE: agree,
      DISAGREE: disagree,
      EXCELlENT: excellent,
      VERY_SATISFACTORY: verySatisfactory,
      SATISFACTORY: satisfactory,
      FAIR: fair,
      POOR: poor,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map[ID] as String,
      question: map[QUESTION] as String,
      questionNumber: map[QUESTION_NUMBER] as int,
      type: map[TYPE] as String,
      agree: map[AGREE] as int,
      disagree: map[DISAGREE] as int,
      excellent: map[EXCELlENT] as int,
      verySatisfactory: map[VERY_SATISFACTORY] as int,
      satisfactory: map[SATISFACTORY] as int,
      fair: map[FAIR] as int,
      poor: map[POOR] as int,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}


// ***** ***** //

// class QuestionModel {
//   static const ID = 'questionId';
//   static const QUESTION_NUMBER = 'questionNumber';
//   static const QUESTION = 'question';
//   static const CHOICES = 'choices';
//   static const TYPE = 'type';
//   static const CREATED_AT = 'created_at';
//   static const UPDATED_AT = 'updated_at';

//   final String id;
//   final String question;
//   final int questionNumber;
//   final String type;
//   final ChoicesDetails choice;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   QuestionModel({
//     required this.id,
//     required this.question,
//     required this.questionNumber,
//     required this.type,
//     required this.choice,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       ID: id,
//       QUESTION: question,
//       QUESTION_NUMBER: questionNumber,
//       TYPE: type,
//       CHOICES: choice.toMap(),
//       CREATED_AT: FieldValue.serverTimestamp(),
//       UPDATED_AT: FieldValue.serverTimestamp(),
//     };
//   }

//   factory QuestionModel.fromMap(Map<String, dynamic> map) {
//     return QuestionModel(
//       id: map[ID] as String,
//       question: map[QUESTION] as String,
//       questionNumber: map[QUESTION_NUMBER] as int,
//       type: map[TYPE] as String,
//       choice: ChoicesDetails.fromMap(map[CHOICES] as Map<String, dynamic>),
//       createdAt: (map[CREATED_AT] as Timestamp).toDate(),
//       updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
//     );
//   }
// }

// class ChoicesDetails {
//   static const POINTS1 = 'point1';
//   static const RATING1 = 'rating1';
//   static const POINTS2 = 'point2';
//   static const RATING2 = 'rating2';
//   static const POINTS3 = 'point3';
//   static const RATING3 = 'rating3';
//   static const POINTS4 = 'point4';
//   static const RATING4 = 'rating4';
//   static const POINTS5 = 'point5';
//   static const RATING5 = 'rating5';

//   final String? points1;
//   final String? rating1;
//   final String? points2;
//   final String? rating2;
//   final String? points3;
//   final String? rating3;
//   final String? points4;
//   final String? rating4;
//   final String? points5;
//   final String? rating5;

//   ChoicesDetails({
//     this.points1,
//     this.rating1,
//     this.points2,
//     this.rating2,
//     this.points3,
//     this.rating3,
//     this.points4,
//     this.rating4,
//     this.points5,
//     this.rating5,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       POINTS1: points1,
//       RATING1: rating1,
//       POINTS2: points2,
//       RATING2: rating2,
//       POINTS3: points3,
//       RATING3: rating3,
//       POINTS4: points4,
//       RATING4: rating4,
//       POINTS5: points5,
//       RATING5: rating5,
//     };
//   }

//   factory ChoicesDetails.fromMap(Map<String, dynamic> map) {
//     return ChoicesDetails(
//       points1: map[POINTS1] != null ? map[POINTS1] as String : null,
//       rating1: map[RATING1] != null ? map[RATING1] as String : null,
//       points2: map[POINTS2] != null ? map[POINTS2] as String : null,
//       rating2: map[RATING2] != null ? map[RATING2] as String : null,
//       points3: map[POINTS3] != null ? map[POINTS3] as String : null,
//       rating3: map[RATING3] != null ? map[RATING3] as String : null,
//       points4: map[POINTS4] != null ? map[POINTS4] as String : null,
//       rating4: map[RATING4] != null ? map[RATING4] as String : null,
//       points5: map[POINTS5] != null ? map[POINTS5] as String : null,
//       rating5: map[RATING5] != null ? map[RATING5] as String : null,
//     );
//   }
// }
