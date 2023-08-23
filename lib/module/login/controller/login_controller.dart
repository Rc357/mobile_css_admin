import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/repositories/auth_repository.dart';
import 'package:admin/splash/controller/check_internet_controller.dart';
import 'package:admin/utils/app_snackbar_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum LoginStatus { initial, loading, success, failed }

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final checkInternetController = CheckInternetController.instance;
  late Worker _statusEverWorker;

  final _status = LoginStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  late DateTime timeIn;
  final userEmail = ''.obs;
  final password = ''.obs;
  final passIsEncrypted = true.obs;

  LoginStatus get status => _status.value;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  bool get isLoading => _status.value == LoginStatus.loading;

  String currentState() =>
      'LoginController(_status: ${_status.value}, userName: ${userEmail.value}, password: ${password.value}';

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
          case LoginStatus.failed:
            MyLogger.printError(currentState());
            break;
          case LoginStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case LoginStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case LoginStatus.success:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void updateUsername(String email) {
    userEmail.value = email;
    MyLogger.printInfo(currentState());
  }

  void updatePassword(String pass) {
    password.value = pass;
    MyLogger.printInfo(currentState());
  }

  void setPassEncryption() {
    passIsEncrypted.value = !passIsEncrypted.value;
  }

  Future<void> loginUser() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    if (!isValidationSuccessful) {
      AppSnackbar.showErrorInfo(
        message: 'Ensure all fields are filled out properly',
      );
      return;
    }
    _status.value = LoginStatus.loading;

    try {
      await AuthRepository.logInWithEmailAndPassword(
        email: userEmail.value,
        password: password.value,
      );
      _status.value = LoginStatus.success;
    } on FirebaseAuthException catch (e) {
      MyLogger.printError(e);
      _showFirebaseError(e.code);
      _status.value = LoginStatus.failed;
    } catch (e) {
      MyLogger.printError(e);
      AppSnackbar.showErrorInfo(message: 'Please try again later');
      _status.value = LoginStatus.failed;
    }
  }

  void _showFirebaseError(String errorCode) {
    switch (errorCode) {
      case 'user-disabled':
        AppSnackbar.showErrorInfo(message: 'your account has been disabled');
        break;
      case 'wrong-password':
        AppSnackbar.showErrorInfo(
          message: 'The email or password is invalid',
        );
        break;
      case 'user-not-found':
        AppSnackbar.showErrorInfo(
          message: 'The email or password is invalid',
        );
        break;
      default:
        AppSnackbar.showErrorInfo(message: 'Please try again later');
    }
  }
}
