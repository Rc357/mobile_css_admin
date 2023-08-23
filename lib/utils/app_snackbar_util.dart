import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AppSnackbar {
  static const _duration = Duration(seconds: 6);

  static void showSuccessInfo({
    String? title,
    required String message,
  }) {
    Get.snackbar(
      title ?? 'Well Done',
      message,
      icon: const Icon(LineIcons.check),
      duration: _duration,
    );
  }

  static void showWarningInfo({
    String? title,
    required String message,
  }) {
    Get.snackbar(
      title ?? 'Warning',
      message,
      icon: const Icon(LineIcons.exclamationTriangle),
      duration: _duration,
    );
  }

  static void showErrorInfo({
    String? title,
    required String message,
  }) {
    Get.snackbar(
      title ?? 'Error',
      message,
      icon: const Icon(LineIcons.times),
      duration: _duration,
    );
  }
}
