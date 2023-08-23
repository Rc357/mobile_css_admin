import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:get/get.dart';

class AddSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddSurveyController());
  }
}
