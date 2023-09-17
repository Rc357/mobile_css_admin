import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:admin/utils/app_snackbar_util.dart';

import 'package:get/get.dart';

enum DeleteAdminStatus { initial, loading, deleted, failed }

class DeleteAdminController extends GetxController {
  static DeleteAdminController get instance => Get.find();
  late Worker _statusEverWorker;

  final getAllAminController = GetAllAminController.instance;

  final _status = DeleteAdminStatus.initial.obs;

  final officeName = ''.obs;

  bool get isLoading => _status.value == DeleteAdminStatus.loading;

  String currentState() => 'GetAllAminController(_status: ${_status.value},)';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    _monitorExhibitorAllProductsStatus();
  }

  @override
  void onClose() {
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorExhibitorAllProductsStatus() {
    _statusEverWorker = ever(
      _status,
      (value) {
        switch (value) {
          case DeleteAdminStatus.failed:
            MyLogger.printError(currentState());
            break;
          case DeleteAdminStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case DeleteAdminStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case DeleteAdminStatus.deleted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void deleteAdmin(AdminModel adminData) async {
    _status.value = DeleteAdminStatus.loading;
    MyLogger.printInfo('ADMIN ID : ${adminData.id}');
    try {
      await AddAdminRepository.deleteAdmin(adminId: adminData.id);
      _status.value = DeleteAdminStatus.deleted;
      MyLogger.printInfo(currentState());
      AppSnackbar.showSuccessInfo(
        title: 'Success',
        message: 'Admin successfully deleted. ',
      );
    } on Exception catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Deleting admins error',
        message: 'Unable to delete admin $e',
      );

      _status.value = DeleteAdminStatus.failed;
    } catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Deleting admins error'.tr,
        message: 'Unable to delete admin',
      );
      _status.value = DeleteAdminStatus.failed;
    }

    getAllAminController.fetchAllAdmins();
  }
}
