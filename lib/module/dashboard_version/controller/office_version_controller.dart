import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:admin/routes/app_pages.dart';

import 'package:get/get.dart';

enum OfficeVersionStatus { initial, loading, submitted, loaded, failed }

class OfficeVersionController extends GetxController {
  static OfficeVersionController get instance => Get.find();

  late Worker _statusEverWorker;
  final _status = OfficeVersionStatus.initial.obs;

  final questionVersion = ''.obs;
  final allQuestionnaireVersion = <QuestionnaireVersionModel>[].obs;

  final officeName = ''.obs;

  OfficeVersionStatus get status => _status.value;
  bool get isLoading => _status.value == OfficeVersionStatus.loading;
  final questionType = QuestionTypeEnum.unknown.obs;

  String currentState() =>
      'OfficeVersionController(_status: ${_status.value}, )';

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
          case OfficeVersionStatus.failed:
            MyLogger.printError(currentState());
            break;
          case OfficeVersionStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case OfficeVersionStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case OfficeVersionStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
          case OfficeVersionStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  Future<void> getQuestionnaireVersions(String name) async {
    _status.value = OfficeVersionStatus.loading;
    officeName.value = name;
    try {
      allQuestionnaireVersion.value =
          await QuestionsRepository.getQuestionnaireVersion(name);

      _status.value = OfficeVersionStatus.loaded;
    } catch (e) {
      print('Error: $e');
    }
  }

  void toOfficeScreen(QuestionnaireVersionModel version) {
    if (officeName.value == 'questionnaireVersionLibrary') {
      Get.toNamed(AppPages.DASHBOARD_LIBRARY, arguments: version);
    }
    if (officeName.value == 'questionnaireVersionCashier') {
      Get.toNamed(AppPages.DASHBOARD_CASHIER, arguments: version);
    }
    if (officeName.value == 'questionnaireVersionRegistrar') {
      Get.toNamed(AppPages.DASHBOARD_REGISTRAR, arguments: version);
    }
    if (officeName.value == 'questionnaireVersionSecurityOffice') {
      Get.toNamed(AppPages.DASHBOARD_SECURITY, arguments: version);
    }
    if (officeName.value == 'questionnaireVersionAdminsOffice') {
      Get.toNamed(AppPages.DASHBOARD_ADMIN_OFFICE, arguments: version);
    }
  }
}
