import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/question_model.dart';
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

  // static Future<void> updateAdmin(AdminModel admin) async {
  //   try {
  //     final docRef = firestore.collection(_admins).doc(admin.id);
  //     await docRef.update(admin.toMap());
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  // static Future<Future<DocumentSnapshot<Map<String, dynamic>>>> getAdminViaId(
  //     String id) async {
  //   try {
  //     final adminData = firestore.collection(_admins).doc(id).get();
  //     return adminData;
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  static Future<List<QuestionModel>> getQuestions(String office) async {
    final collectionRef = firestore.collection(office);
    final query = collectionRef.orderBy(QuestionModel.QUESTION_NUMBER);
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

  static Future<List<ThankYouMessageModel>> getMessages(String office) async {
    final collectionRef = firestore.collection(office);
    final query = collectionRef.orderBy(ThankYouMessageModel.CREATED_AT);
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
}
