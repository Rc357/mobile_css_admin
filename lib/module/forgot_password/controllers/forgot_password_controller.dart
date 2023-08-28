import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/repositories/auth_repository.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:admin/utils/app_snackbar_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum ForgotPasswordStatus { initial, sending, sent, error }

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();
  final status = ForgotPasswordStatus.initial.obs;
  late Worker? _statusEverWorker;

  final formKey = GlobalKey<FormBuilderState>();
  late TextEditingController emailController;

  bool get isSending => status.value == ForgotPasswordStatus.sending;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    _monitorForgotPasswordStatus();
  }

  @override
  void onClose() {
    emailController.dispose();
    _statusEverWorker?.dispose();
    super.onClose();
  }

  void _monitorForgotPasswordStatus() {
    _statusEverWorker = ever(
      status,
      (value) {
        if (value == ForgotPasswordStatus.error) {
          MyLogger.printError(currentState());
        }
        if (value == ForgotPasswordStatus.sending) {
          MyLogger.printInfo(currentState());
        }
        if (value == ForgotPasswordStatus.initial) {
          MyLogger.printInfo(currentState());
        }
        if (value == ForgotPasswordStatus.sent) {
          MyLogger.printInfo(currentState());
          Get.offNamed(AppPages.LOGIN);
        }
      },
    );
  }

  Future<void> requestPasswordResetLink() async {
    final isValidationSuccessful = formKey.currentState?.validate() ?? false;
    if (isValidationSuccessful) {
      status.value = ForgotPasswordStatus.sending;
      try {
        await AuthRepository.sendPasswordResetEmail(
          email: emailController.text.trim(),
        ).then((_) => MyLogger.printInfo('PASSWORD RESET EMAIL SENT'));
        AppSnackbar.showSuccessInfo(
          title: 'Password Reset Email Sent',
          message: 'Please check your inbox or spam folder',
        );
        status.value = ForgotPasswordStatus.sent;
      } on FirebaseAuthException catch (e) {
        MyLogger.printError(e);
        status.value = ForgotPasswordStatus.error;
        AppSnackbar.showErrorInfo(
          title: 'Forgot Password Error',
          message: e.message ?? e.code,
        );
      } catch (e) {
        MyLogger.printError(e);
        status.value = ForgotPasswordStatus.error;
        AppSnackbar.showErrorInfo(
          title: 'Forgot Password Error',
          message: 'Please try again later',
        );
      }
    } else {
      AppSnackbar.showWarningInfo(
        title: 'Form Error',
        message: 'Please ensure that all fields are correctly filled in.',
      );
    }
  }

  String currentState() => 'ForgotPasswordController(status: ${status.value})';
}
