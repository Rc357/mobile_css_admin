import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum EditSurveyVersionStatus { initial, loading, submitted, failed }

class EditSurveyVersionController extends GetxController {
  static EditSurveyVersionController get instance => Get.find();
  late Worker _statusEverWorker;

  final addSurveyVersionController = AddSurveyVersionController.instance;

  final _status = EditSurveyVersionStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  final args = Get.arguments as ArgumentsToPass;

  final imageURL = ''.obs;

  EditSurveyVersionStatus get status => _status.value;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  bool get isLoading => _status.value == EditSurveyVersionStatus.loading;

  final questionVersionUpdate = ''.obs;
  final oldQuestion = Rxn<QuestionnaireVersionModel>();

  String currentState() => 'AddSurveyController(_status: ${_status.value},)';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    _monitorLoginStatus();
  }

  @override
  void onClose() {
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorLoginStatus() {
    _statusEverWorker = ever(
      _status,
      (value) {
        switch (value) {
          case EditSurveyVersionStatus.failed:
            MyLogger.printError(currentState());
            break;
          case EditSurveyVersionStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case EditSurveyVersionStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case EditSurveyVersionStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void updateOldQuestion(QuestionnaireVersionModel question) {
    oldQuestion.value = question;

    if (oldQuestion.value != null) {
      questionVersionUpdate.value =
          oldQuestion.value!.questionnaireVersion.toString();
    }
  }

  void updateQuestionVersion(String value) {
    questionVersionUpdate.value = value;
  }

  Future<bool> submitUpdateQuestionnaireVersion() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    _status.value = EditSurveyVersionStatus.loading;

    if (!isValidationSuccessful) {
      Get.snackbar(
        'Warning!',
        "Please make sure no empty field.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      _status.value = EditSurveyVersionStatus.submitted;
      _updateQuestionVersion();
      Get.snackbar(
        'Success!',
        "Question Edited Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      return true;
    }
    return false;
  }

  Future<void> _updateQuestionVersion() async {
    if (questionVersionUpdate.value.isEmpty) {
      Get.snackbar(
        'Warning!',
        "Version number is required.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      try {
        final version = QuestionnaireVersionModel(
          id: oldQuestion.value!.id,
          questionnaireVersion: int.parse(questionVersionUpdate.value),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await QuestionsRepository.updateQuestionnaireVersionAdmin(
            version, args.questionnaireOffice);

        addSurveyVersionController.getQuestionnaireVersions();
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
