import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/survey_remarks.dart';

class RemarksRepository {
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
}
