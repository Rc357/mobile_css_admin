import 'dart:io';

import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';

enum DeleteSurveyStatus { initial, loading, deleted, failed }

class DeleteSurveyController extends GetxController {
  static DeleteSurveyController get instance => Get.find();
  late Worker _statusEverWorker;

  final addSurveyController = AddSurveyController.instance;
  final _status = DeleteSurveyStatus.initial.obs;
  final args = Get.arguments as AdminModel;

  Rxn<File> selectedImage = Rxn<File>();
  DeleteSurveyStatus get status => _status.value;
  bool get isLoading => _status.value == DeleteSurveyStatus.loading;

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
          case DeleteSurveyStatus.failed:
            MyLogger.printError(currentState());
            break;
          case DeleteSurveyStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case DeleteSurveyStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case DeleteSurveyStatus.deleted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void deleteQuestion(String questionId) async {
    _status.value = DeleteSurveyStatus.loading;
    final officeName = 'questions' +
        args.adminType.description
            .replaceAll(RegExp(r'[^\w\s ]+'), "")
            .removeAllWhitespace;

    final isSuccess =
        await QuestionsRepository.deleteQuestionAdmin(officeName, questionId);

    if (isSuccess) {
      Get.snackbar(
        'Success!',
        "Question Deleted Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteSurveyStatus.deleted;
    } else {
      Get.snackbar(
        'Failed!',
        "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteSurveyStatus.failed;
    }

    addSurveyController.getQuestions();
  }
}
