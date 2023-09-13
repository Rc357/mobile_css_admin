import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/user_admin_office_model.dart';
import 'package:admin/models/user_cashier_model.dart';
import 'package:admin/models/user_library_model.dart';
import 'package:admin/models/user_registrar_model.dart';
import 'package:admin/models/user_security_office_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static const queryLimit = 20;
  static const String _userData = 'user';
  static const String _dateCreated = 'created_at';
  static const String _version = 'version';
  static const String _answered = 'answered';

  static Future<List<UserSecurityOfficeModel>> getUsersSecurityOffice(
      {DocumentSnapshot? lastDocumentSnapshot,
      String? office,
      required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserSecurityOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserRegistrarModel>> getUsersRegistrar(
      {DocumentSnapshot? lastDocumentSnapshot,
      String? office,
      required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserRegistrarModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserCashierModel>> getUsersCashier(
      {DocumentSnapshot? lastDocumentSnapshot,
      String? office,
      required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserCashierModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserAdminOfficeModel>> getUsersAdminOffice(
      {DocumentSnapshot? lastDocumentSnapshot,
      String? office,
      required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserAdminOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserLibraryModel>> getUsersLibrary(
      {DocumentSnapshot? lastDocumentSnapshot,
      String? office,
      required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);
      if (lastDocumentSnapshot != null) {
        query = query.startAfterDocument(lastDocumentSnapshot);
      } else {
        query = query;
      }

      final result = await query.get();
      return result.docs.map(UserLibraryModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserLibraryModel>> getUsersLibraryAnswered(
      {String? office, required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);

      final result = await query.get();
      return result.docs.map(UserLibraryModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserAdminOfficeModel>> getUsersAdminOfficeAnswered(
      {String? office, required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);

      final result = await query.get();
      return result.docs.map(UserAdminOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserCashierModel>> getUsersCashierOfficeAnswered(
      {String? office, required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);

      final result = await query.get();
      return result.docs.map(UserCashierModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserRegistrarModel>> getUsersRegistrarOfficeAnswered(
      {String? office, required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);

      final result = await query.get();
      return result.docs.map(UserRegistrarModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserSecurityOfficeModel>> getUsersSecurityOfficeAnswered(
      {String? office, required int version}) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .orderBy(_dateCreated, descending: true)
          .limit(queryLimit);

      final result = await query.get();
      return result.docs.map(UserSecurityOfficeModel.fromDocument).toList();
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
