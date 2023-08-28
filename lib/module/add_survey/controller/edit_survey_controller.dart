import 'dart:io';

import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum EditSurveyStatus { initial, loading, submitted, failed }

class EditSurveyController extends GetxController {
  static EditSurveyController get instance => Get.find();
  late Worker _statusEverWorker;

  final addSurveyController = AddSurveyController.instance;

  final _status = EditSurveyStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  final args = Get.arguments as AdminModel;

  final thankYouMessage = ''.obs;

  final imageName = ''.obs;
  final imageURL = ''.obs;

  Rxn<File> selectedImage = Rxn<File>();

  EditSurveyStatus get status => _status.value;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  bool get isLoading => _status.value == EditSurveyStatus.loading;

//Edit Questions Variables
  final questionTypeUpdate = QuestionTypeEnum.unknown.obs;
  final questionUpdate = ''.obs;
  final oldQuestion = Rxn<QuestionModel>();

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
          case EditSurveyStatus.failed:
            MyLogger.printError(currentState());
            break;
          case EditSurveyStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case EditSurveyStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case EditSurveyStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void updateOldQuestion(QuestionModel question) {
    oldQuestion.value = question;

    if (oldQuestion.value != null) {
      questionUpdate.value = oldQuestion.value!.question;
      questionTypeUpdate.value = oldQuestion.value!.type;
    }
  }

  void updateQuestionTypeUpdate(QuestionTypeEnum type) {
    questionTypeUpdate.value = type;
  }

  void updateQuestion(String value) {
    questionUpdate.value = value;
  }

  void updateThankYouMessage(String message) {
    thankYouMessage.value = message;
  }

  Future<bool> submitUpdateQuestion(QuestionModel question) async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    _status.value = EditSurveyStatus.loading;

    if (!isValidationSuccessful) {
      Get.snackbar(
        'Warning!',
        "Please make sure no empty field.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      if (questionTypeUpdate.value == QuestionTypeEnum.unknown) {
        Get.snackbar(
          'Warning!',
          "Please select answer type.",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );
        return false;
      }
      final officeName = 'questions' +
          args.adminType.description
              .replaceAll(RegExp(r'[^\w\s ]+'), "")
              .removeAllWhitespace;
      try {
        await QuestionsRepository.updateQuestionAdmin(officeName, question,
            questionUpdate.value, questionTypeUpdate.value);
      } catch (e) {
        print('Error: $e');
      }
      _status.value = EditSurveyStatus.submitted;
      addSurveyController.getQuestions();
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
}
