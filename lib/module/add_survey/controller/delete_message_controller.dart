import 'package:admin/repositories/questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';

enum DeleteMessageStatus { initial, loading, deleted, failed }

class DeleteMessageController extends GetxController {
  static DeleteMessageController get instance => Get.find();
  late Worker _statusEverWorker;

  final addSurveyController = AddSurveyController.instance;
  final _status = DeleteMessageStatus.initial.obs;
  final args = Get.arguments as AdminModel;

  DeleteMessageStatus get status => _status.value;
  bool get isLoading => _status.value == DeleteMessageStatus.loading;

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
          case DeleteMessageStatus.failed:
            MyLogger.printError(currentState());
            break;
          case DeleteMessageStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case DeleteMessageStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case DeleteMessageStatus.deleted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void deleteMessage(String messageId) async {
    _status.value = DeleteMessageStatus.loading;
    final officeName = 'regards' +
        args.adminType.description
            .replaceAll(RegExp(r'[^\w\s ]+'), "")
            .removeAllWhitespace;

    final isSuccess =
        await QuestionsRepository.deleteQuestionAdmin(officeName, messageId);

    if (isSuccess) {
      Get.snackbar(
        'Success!',
        "Message Deleted Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteMessageStatus.deleted;
    } else {
      Get.snackbar(
        'Failed!',
        "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      _status.value = DeleteMessageStatus.failed;
    }
    addSurveyController.getMessages();
  }
}
