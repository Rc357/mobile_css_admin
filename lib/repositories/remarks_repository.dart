import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/survey_remarks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemarksRepository {
  static const String _refId = 'referenceUser';
  static const String _version = 'version';
  static const String _officeName = 'officeName';
  static const String _surveyRemarks = 'surveyRemarks';

  static Future<List<SurveyRemarksModel>?> getRemarksList(
      String office, int version) async {
    final collectionRef = firestore.collection(_surveyRemarks);
    final query = collectionRef
        .where(_officeName, isEqualTo: office)
        .where(_version, isEqualTo: version)
        .orderBy(SurveyRemarksModel.CREATED_AT, descending: true);
    final result = await query.get();
    if (result.docs.isNotEmpty) {
      final remarks = result.docs.map((doc) {
        final map = doc.data();
        return SurveyRemarksModel.fromMap(map);
      }).toList();
      return remarks;
    } else {
      return null;
    }
  }

  static Future<List<SurveyRemarksModel>?> getRemarksListFilter(
      String office, int version, DateTime start, DateTime end) async {
    var dateStart = Timestamp.fromDate(start);
    var dateEnd = Timestamp.fromDate(end);
    final collectionRef = firestore.collection(_surveyRemarks);
    final query = collectionRef
        .where(_officeName, isEqualTo: office)
        .where(_version, isEqualTo: version)
        .where('created_at', isGreaterThanOrEqualTo: dateStart)
        .where('created_at', isLessThanOrEqualTo: dateEnd)
        .orderBy(SurveyRemarksModel.CREATED_AT, descending: true);
    final result = await query.get();
    if (result.docs.isNotEmpty) {
      final remarks = result.docs.map((doc) {
        final map = doc.data();
        return SurveyRemarksModel.fromMap(map);
      }).toList();
      return remarks;
    } else {
      return null;
    }
  }

  static Future<String> getRemarksListViaUID(
    String office,
    String id,
    int version,
  ) async {
    final collectionRef = firestore.collection(_surveyRemarks);
    final query = collectionRef
        .where(_officeName, isEqualTo: office)
        .where(_version, isEqualTo: version)
        .where(_refId, isEqualTo: id)
        .orderBy(SurveyRemarksModel.CREATED_AT, descending: true);
    final result = await query.get();

    if (result.docs.isNotEmpty) {
      final map = result.docs.first.data();
      final remarksData = SurveyRemarksModel.fromMap(map);
      return remarksData.remarks;
    } else {
      return 'N/A';
    }
  }
}
