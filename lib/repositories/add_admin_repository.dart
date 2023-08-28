import 'package:admin/enums/admin_enum.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAdminRepository {
  static const String _admins = 'admins';
  static const String _adminType = 'admin_type';

  static Future<void> createNewAdmin(AdminModel admin) async {
    try {
      final docRef = firestore.collection(_admins).doc(admin.id);
      await docRef.set(admin.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateAdmin(AdminModel admin) async {
    try {
      final docRef = firestore.collection(_admins).doc(admin.id);
      await docRef.update(admin.toMap());
    } catch (_) {
      rethrow;
    }
  }

  static Future<AdminModel> getAdminViaId(String id) async {
    try {
      final adminRef = await firestore.collection(_admins).doc(id).get();
      if (!adminRef.exists) {
        throw ('Admin with id $id does not exist');
      }
      final map = adminRef.data() as Map<String, dynamic>;
      final adminData = AdminModel.fromMap(map);
      return adminData;
    } catch (_) {
      rethrow;
    }
  }

  static Future<List<AdminModel>> getAllAdmins({
    DocumentSnapshot? lastDocumentSnapshot,
  }) async {
    Query query = firestore.collection(_admins).where(_adminType, whereIn: [
      AdminTypeEnum.LibraryAdmin.name,
      AdminTypeEnum.SecurityAdmin.name,
      AdminTypeEnum.RegistrarAdmin.name,
      AdminTypeEnum.CashierAdmin.name,
      AdminTypeEnum.Admin.name,
    ]).orderBy(AdminModel.CREATED_AT, descending: true);

    if (lastDocumentSnapshot != null) {
      query = query.startAfterDocument(lastDocumentSnapshot);
    } else {
      query = query;
    }
    final result = await query.get();
    return result.docs.map(AdminModel.fromDocument).toList();
  }

  static Future<void> deleteAdmin({
    required String adminId,
  }) async {
    final docRef = firestore.collection(_admins);
    docRef.doc(adminId).delete();
  }
}
