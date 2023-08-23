import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/survey_library_model.dart';

class GetSurveysRepository {
  static Future<List<SurveyLibraryModel>> getAllLibrarySurvey(
      String office) async {
    final collectionRef = firestore.collection(office);
    final query = collectionRef.orderBy(SurveyLibraryModel.CREATED_AT);
    final result = await query.get();
    final admins = result.docs.map((doc) {
      final map = doc.data();
      return SurveyLibraryModel.fromMap(map);
    }).toList();
    return admins;
  }
}
