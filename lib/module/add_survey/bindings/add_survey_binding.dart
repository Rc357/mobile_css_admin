import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:admin/module/add_survey/controller/delete_message_controller.dart';
import 'package:admin/module/add_survey/controller/delete_survey_controller.dart';
import 'package:admin/module/add_survey/controller/edit_message_controller.dart';
import 'package:admin/module/add_survey/controller/edit_survey_controller.dart';
import 'package:get/get.dart';

class AddSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddSurveyController());
    Get.put(EditSurveyController());
    Get.put(DeleteSurveyController());
    Get.put(EditMessageController());
    Get.put(DeleteMessageController());
  }
}
