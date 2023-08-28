import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/repositories/auth_repository.dart';
import 'package:admin/splash/controller/check_internet_controller.dart';
import 'package:admin/utils/app_snackbar_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum LogOutStatus { initial, loading, success, failed }

class LogOutController extends GetxController {
  static LogOutController get instance => Get.find();
  final checkInternetController = CheckInternetController.instance;
  late Worker _statusEverWorker;

  final _status = LogOutStatus.initial.obs;

  bool get isLoading => _status.value == LogOutStatus.loading;

  String currentState() => 'LogOutController(_status: ${_status.value}, )';

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
          case LogOutStatus.failed:
            MyLogger.printError(currentState());
            break;
          case LogOutStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case LogOutStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case LogOutStatus.success:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  Future<void> logOutAdmin() async {
    try {
      await AuthRepository.logout();
      _status.value = LogOutStatus.success;
    } on FirebaseAuthException catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Something went wrong.',
        message: 'Error :  $e',
      );
      _status.value = LogOutStatus.failed;
    } catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(
        title: 'Something went wrong.',
        message: 'Please try again',
      );
      _status.value = LogOutStatus.failed;
    }
  }
}
