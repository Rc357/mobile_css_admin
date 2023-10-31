import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/user_admin_office_model.dart';
import 'package:admin/models/user_cashier_model.dart';
import 'package:admin/models/user_library_model.dart';
import 'package:admin/models/user_registrar_model.dart';
import 'package:admin/models/user_security_office_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static const queryLimit = 15;
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

  static Future<DocumentSnapshot<Map<String, dynamic>>>
      getUsersDocumentSnapshot(
    String office,
    String userId,
  ) async {
    print('userId $userId');
    print('office $office');
    try {
      final docRef = firestore.collection(office).doc(userId);
      final itemData = await docRef.get();
      return itemData;
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
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserLibraryModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserLibraryModel>> getUsersLibraryAnsweredFilter({
    String? office,
    required int version,
    required DateTime start,
    required DateTime end,
  }) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      var dateStart = Timestamp.fromDate(start);
      var dateEnd = Timestamp.fromDate(end);
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .where('created_at', isGreaterThanOrEqualTo: dateStart)
          .where('created_at', isLessThanOrEqualTo: dateEnd)
          .orderBy(_dateCreated, descending: true);

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
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserAdminOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserAdminOfficeModel>> getUsersAdminOfficeAnsweredFilter({
    String? office,
    required int version,
    required DateTime start,
    required DateTime end,
  }) async {
    var dateStart = Timestamp.fromDate(start);
    var dateEnd = Timestamp.fromDate(end);
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .where('created_at', isGreaterThanOrEqualTo: dateStart)
          .where('created_at', isLessThanOrEqualTo: dateEnd)
          .orderBy(_dateCreated, descending: true);

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
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserCashierModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserCashierModel>> getUsersCashierOfficeAnsweredFilter({
    String? office,
    required int version,
    required DateTime start,
    required DateTime end,
  }) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      var dateStart = Timestamp.fromDate(start);
      var dateEnd = Timestamp.fromDate(end);
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .where('created_at', isGreaterThanOrEqualTo: dateStart)
          .where('created_at', isLessThanOrEqualTo: dateEnd)
          .orderBy(_dateCreated, descending: true);

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
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserRegistrarModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserRegistrarModel>>
      getUsersRegistrarOfficeAnsweredFilter({
    String? office,
    required int version,
    required DateTime start,
    required DateTime end,
  }) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      var dateStart = Timestamp.fromDate(start);
      var dateEnd = Timestamp.fromDate(end);
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .where('created_at', isGreaterThanOrEqualTo: dateStart)
          .where('created_at', isLessThanOrEqualTo: dateEnd)
          .orderBy(_dateCreated, descending: true);

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
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserSecurityOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<UserSecurityOfficeModel>>
      getUsersSecurityOfficeAnsweredFilter({
    String? office,
    required int version,
    required DateTime start,
    required DateTime end,
  }) async {
    MyLogger.printInfo('COLLECTION NAME: $office, VERSION: $version');
    try {
      var dateStart = Timestamp.fromDate(start);
      var dateEnd = Timestamp.fromDate(end);
      Query query = firestore
          .collection(office!)
          .where(_version, isEqualTo: version)
          .where(_answered, isEqualTo: true)
          .where('created_at', isGreaterThanOrEqualTo: dateStart)
          .where('created_at', isLessThanOrEqualTo: dateEnd)
          .orderBy(_dateCreated, descending: true);

      final result = await query.get();
      return result.docs.map(UserSecurityOfficeModel.fromDocument).toList();
    } catch (_) {
      rethrow;
    }
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocumentSnapshot(
    String userId,
  ) async {
    try {
      final docRef = firestore.collection(_userData).doc(userId);
      final itemData = await docRef.get();
      return itemData;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateUserViaVersion(
      String officeName, int version) async {
    MyLogger.printInfo('Office : $officeName, version : $version');
    var collection = firestore.collection(officeName);

    try {
      QuerySnapshot querySnapshot =
          await collection.where(_version, isEqualTo: version).get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await collection.doc(documentSnapshot.id).delete();
      }
    } catch (e) {
      MyLogger.printError("updateUserViaVersion ERROR: $e");
      return;
    }
  }
}
