import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:admin/utils/app_snackbar_util.dart';
import 'package:get/get.dart';

enum GetAllAminStatus { initial, fetching, fetched, failed }

class GetAllAminController extends GetxController {
  static GetAllAminController get instance => Get.find();
  late Worker _statusEverWorker;

  final _status = GetAllAminStatus.initial.obs;
  final _allAdmins = <AdminModel>[].obs;

  final officeName = ''.obs;

  bool get isLoading => _status.value == GetAllAminStatus.fetching;
  List<AdminModel> get allAdmins => _allAdmins;

  String currentState() =>
      'GetAllAminController(_status: ${_status.value},  _allAdmins: ${allAdmins.length})';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    _monitorExhibitorAllProductsStatus();
    fetchAllAdmins();
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
          case GetAllAminStatus.failed:
            MyLogger.printError(currentState());
            break;
          case GetAllAminStatus.fetching:
            MyLogger.printInfo(currentState());
            break;
          case GetAllAminStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case GetAllAminStatus.fetched:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  Future<void> fetchAllAdmins() async {
    _status.value = GetAllAminStatus.fetching;
    try {
      _allAdmins.value = await AddAdminRepository.getAllAdmins();
      _status.value = GetAllAminStatus.fetched;
      MyLogger.printInfo(currentState());
    } on Exception catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Getting admins error',
        message: 'Getting all admins error: $e',
      );
      _status.value = GetAllAminStatus.failed;
    } catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Getting admins empty'.tr,
        message: 'Unable to fetch admins',
      );
      _status.value = GetAllAminStatus.failed;
    }
  }
}
