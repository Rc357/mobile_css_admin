import 'package:admin/enums/admin_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/module/dashboard_version/controller/office_version_controller.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  static MainScreenController get instance => Get.find();

  final officeVersionController = OfficeVersionController.instance;
  final currentScreenIndex = 0.obs;
  final questionnaireVersionName = ''.obs;
  final nameDisplay = ''.obs;

  final adminView = AdminTypeEnum.Unknown.obs;

  String currentState() =>
      'MainScreenController(currentScreenIndex ${currentScreenIndex.value}, questionnaireVersionName: ${questionnaireVersionName.value}, adminView:${adminView.value.name})';

  void updateScreenIndex(int index) async {
    currentScreenIndex.value = index;
    setQuestionnaireName();
    setAdminView(AdminTypeEnum.Unknown);
    await officeVersionController
        .getQuestionnaireVersions(questionnaireVersionName.value);
    MyLogger.printInfo(currentState());
  }

  void setQuestionnaireName() {
    switch (currentScreenIndex.value) {
      case 2:
        questionnaireVersionName.value = 'questionnaireVersionLibrary';
        nameDisplay.value = 'Library';
        break;
      case 3:
        questionnaireVersionName.value = 'questionnaireVersionCashier';
        nameDisplay.value = 'Cashier';
        break;
      case 4:
        questionnaireVersionName.value = 'questionnaireVersionRegistrar';
        nameDisplay.value = 'Registrar';
        break;
      case 5:
        questionnaireVersionName.value = 'questionnaireVersionSecurityOffice';
        nameDisplay.value = 'Security Office';
        break;
      case 6:
        questionnaireVersionName.value = 'questionnaireVersionAdminsOffice';
        nameDisplay.value = "Admin's Office";
        break;
    }
  }

  void setAdminView(AdminTypeEnum admin) {
    adminView.value = admin;
    MyLogger.printInfo(currentState());
  }
}
