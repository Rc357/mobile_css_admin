import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/models/thank_you_message_model.dart';

class QuestionsRepository {
  static Future<void> createNewQuestionAdmin(
      QuestionModel question, String officeName) async {
    MyLogger.printInfo('Office : $officeName');
    try {
      final docRef = firestore.collection(officeName).doc(question.id);
      await docRef.set(question.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateQuestionAdmin(
      String officeName,
      QuestionModel question,
      String questionUpdate,
      QuestionTypeEnum questionType) async {
    final updateQuestion = QuestionModel(
        id: question.id,
        question: questionUpdate,
        type: questionType,
        updatedAt: DateTime.now(),
        yes: question.yes,
        createdAt: question.createdAt,
        no: question.no,
        excellent: question.excellent,
        fair: question.fair,
        poor: question.poor,
        questionNumber: question.questionNumber,
        satisfactory: question.satisfactory,
        verySatisfactory: question.verySatisfactory,
        version: question.version);

    try {
      final docRef = firestore.collection(officeName).doc(question.id);
      await docRef.update(updateQuestion.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<bool> deleteQuestionAdmin(String officeName, String id) async {
    MyLogger.printInfo('Office : $officeName');
    try {
      await firestore.collection(officeName).doc(id).delete();
      return true;
    } catch (e) {
      MyLogger.printError("deleteQuestionAdmin ERROR: $e");
      return false;
    }
  }

  static Future<List<QuestionModel>> getQuestions(
      String office, int version) async {
    MyLogger.printInfo("office: $office, version: $version");
    final collectionRef = firestore.collection(office);
    final query = collectionRef
        .where('version', isEqualTo: version)
        .orderBy(QuestionModel.QUESTION_NUMBER);
    final result = await query.get();
    final admins = result.docs.map((doc) {
      final map = doc.data();
      return QuestionModel.fromMap(map);
    }).toList();
    return admins;
  }

  static Future<void> createNewThankYouMessageAdmin(
      ThankYouMessageModel message, String officeName) async {
    try {
      final docRef = firestore.collection(officeName).doc(message.messageId);
      await docRef.set(message.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateThankYouMessageAdmin(
      ThankYouMessageModel message, String officeName) async {
    try {
      final docRef = firestore.collection(officeName).doc(message.messageId);
      await docRef.update(message.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<bool> deleteMessageAdmin(String refName, String id) async {
    MyLogger.printInfo('Reference : $refName');
    try {
      await firestore.collection(refName).doc(id).delete();
      return true;
    } catch (e) {
      MyLogger.printError("deleteMessageAdmin ERROR: $e");
      return false;
    }
  }

  static Future<List<ThankYouMessageModel>> getMessages(
      String office, int version) async {
    final collectionRef = firestore.collection(office);
    final query = collectionRef
        .where('version', isEqualTo: version)
        .orderBy(ThankYouMessageModel.CREATED_AT, descending: true);
    final result = await query.get();
    final admins = result.docs.map((doc) {
      final map = doc.data();
      return ThankYouMessageModel.fromMap(map);
    }).toList();
    return admins;
  }

  static Future<ThankYouMessageModel> getMessagesViaId(
      String id, String office) async {
    try {
      MyLogger.printInfo('GET ID $id, GET OFFICE $office');
      final messageRef = await firestore.collection(office).doc(id).get();
      if (!messageRef.exists) {
        throw ('message does not exist');
      }
      final map = messageRef.data() as Map<String, dynamic>;
      final message = ThankYouMessageModel.fromMap(map);
      return message;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> createNewQuestionnaireVersionAdmin(
      QuestionnaireVersionModel versionData, String officeName) async {
    MyLogger.printInfo('Office : $officeName');
    try {
      final docRef = firestore.collection(officeName).doc();
      final questionnaireVersionData = QuestionnaireVersionModel(
        id: docRef.id,
        questionnaireVersion: versionData.questionnaireVersion,
        createdAt: versionData.createdAt,
        updatedAt: versionData.updatedAt,
      );
      await docRef.set(questionnaireVersionData.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateQuestionnaireVersionAdmin(
      QuestionnaireVersionModel versionData, String officeName) async {
    MyLogger.printInfo('Office : $officeName');
    try {
      final docRef = firestore.collection(officeName).doc(versionData.id);
      await docRef.update(versionData.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<bool> deleteQuestionnaireVersionAdmin(
      String id, String officeName) async {
    MyLogger.printInfo('ID: $id, OfficeName: $officeName');
    try {
      await firestore.collection(officeName).doc(id).delete();
      return true;
    } catch (e) {
      MyLogger.printError("deleteQuestionnaireVersionAdmin ERROR: $e");
      return false;
    }
  }

  static Future<List<QuestionnaireVersionModel>> getQuestionnaireVersion(
      String office) async {
    final collectionRef = firestore.collection(office);
    final query = collectionRef.orderBy(
        QuestionnaireVersionModel.QUESTIONNAIRE_VERSION,
        descending: true);
    final result = await query.get();
    final admins = result.docs.map((doc) {
      final map = doc.data();
      return QuestionnaireVersionModel.fromMap(map);
    }).toList();
    return admins;
  }

  static Future<void> updateQuestionnaireVersionViaId(
      {required String id, required String office}) async {
    try {
      final docRef = firestore.collection(office).doc(id);
      await docRef.update({"updated_at": DateTime.now()});
    } catch (_) {
      rethrow;
    }
  }
}
