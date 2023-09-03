import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AddSurveyVersionStatus { initial, loading, submitted, loaded, failed }

class AddSurveyVersionController extends GetxController {
  static AddSurveyVersionController get instance => Get.find();

  late Worker _statusEverWorker;
  final _status = AddSurveyVersionStatus.initial.obs;
  final args = Get.arguments as ArgumentsToPass;
  final questionVersion = ''.obs;
  final allQuestionnaireVersion = <QuestionnaireVersionModel>[].obs;

  AddSurveyVersionStatus get status => _status.value;
  bool get isLoading => _status.value == AddSurveyVersionStatus.loading;
  final questionType = QuestionTypeEnum.unknown.obs;

  String currentState() =>
      'AddSurveyVersionController(_status: ${_status.value}, )';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    getQuestionnaireVersions();
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
          case AddSurveyVersionStatus.failed:
            MyLogger.printError(currentState());
            break;
          case AddSurveyVersionStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case AddSurveyVersionStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case AddSurveyVersionStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
          case AddSurveyVersionStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  Future<bool> submitQuestionVersion() async {
    _status.value = AddSurveyVersionStatus.loading;
    _addQuestionVersion();
    _status.value = AddSurveyVersionStatus.submitted;

    Get.snackbar(
      'Success!',
      "Question Added Successful",
      colorText: Colors.white,
      backgroundColor: Colors.lightBlue,
      icon: const Icon(Icons.add_alert),
    );
    return true;
  }

  Future<void> _addQuestionVersion() async {
    try {
      final version = QuestionnaireVersionModel(
        id: '',
        questionnaireVersion: allQuestionnaireVersion.length + 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await QuestionsRepository.createNewQuestionnaireVersionAdmin(
          version, args.questionnaireOffice);

      getQuestionnaireVersions();
    } catch (e) {
      print('Error: $e');
    }
  }

  void getQuestionnaireVersions() async {
    _status.value = AddSurveyVersionStatus.loading;
    try {
      allQuestionnaireVersion.value =
          await QuestionsRepository.getQuestionnaireVersion(
              args.questionnaireOffice);

      _status.value = AddSurveyVersionStatus.loaded;
    } catch (e) {
      print('Error: $e');
    }
  }
}
