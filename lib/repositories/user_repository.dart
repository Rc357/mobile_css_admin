import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static const queryLimit = 20;
  static const String _userData = 'user';
  static const String _dateCreated = 'created_at';
  static const String _service = 'service';

  static Future<List<UserModel>> getUsers(
      {DocumentSnapshot? lastDocumentSnapshot, String? office}) async {
    try {
      Query query = firestore
          .collection(_userData)
          .where(_service, isEqualTo: office)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserModel.fromMap).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocumentSnapshot(
    String userPostId,
  ) async {
    try {
      final docRef = firestore.collection(_userData).doc(userPostId);
      final itemData = await docRef.get();
      return itemData;
    } catch (_) {
      rethrow;
    }
  }
}
