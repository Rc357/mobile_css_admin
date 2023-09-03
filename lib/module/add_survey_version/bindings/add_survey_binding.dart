import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:admin/module/add_survey_version/controller/delete_survey_version_controller.dart';
import 'package:admin/module/add_survey_version/controller/edit_survey_version_controller.dart';
import 'package:get/get.dart';

class AddSurveyVersionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddSurveyVersionController());
    Get.put(EditSurveyVersionController());
    Get.put(DeleteSurveyVersionController());
  }
}
