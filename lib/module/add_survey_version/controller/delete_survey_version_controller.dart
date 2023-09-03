import 'dart:io';

import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/helper/my_logger_helper.dart';

enum DeleteSurveyVersionStatus { initial, loading, deleted, failed }

class DeleteSurveyVersionController extends GetxController {
  static DeleteSurveyVersionController get instance => Get.find();
  late Worker _statusEverWorker;

  final addSurveyController = AddSurveyVersionController.instance;
  final _status = DeleteSurveyVersionStatus.initial.obs;
  final args = Get.arguments as ArgumentsToPass;

  Rxn<File> selectedImage = Rxn<File>();
  DeleteSurveyVersionStatus get status => _status.value;
  bool get isLoading => _status.value == DeleteSurveyVersionStatus.loading;

  String currentState() =>
      'DeleteSurveyVersionController(_status: ${_status.value},)';

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
          case DeleteSurveyVersionStatus.failed:
            MyLogger.printError(currentState());
            break;
          case DeleteSurveyVersionStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case DeleteSurveyVersionStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case DeleteSurveyVersionStatus.deleted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void deleteQuestion(String questionId) async {
    _status.value = DeleteSurveyVersionStatus.loading;

    final isSuccess = await QuestionsRepository.deleteQuestionnaireVersionAdmin(
        questionId, args.questionnaireOffice);

    if (isSuccess) {
      Get.snackbar(
        'Success!',
        "Question Deleted Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteSurveyVersionStatus.deleted;
    } else {
      Get.snackbar(
        'Failed!',
        "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteSurveyVersionStatus.failed;
    }

    addSurveyController.getQuestionnaireVersions();
  }
}
