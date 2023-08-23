import 'package:admin/constants/my_logger.dart';
import 'package:admin/enums/admin_enum.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';

import 'package:admin/repositories/add_admin_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

enum DialogControllerStatus { initial, loading, submitted, error }

class CreateAdminDialogController extends GetxController {
  static CreateAdminDialogController get instance => Get.find();

  final getAllAminController = GetAllAminController.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final status = DialogControllerStatus.initial.obs;
  final myUuid = const Uuid().v4();
  final _formKey = GlobalKey<FormBuilderState>();

  GlobalKey<FormBuilderState> get formKey => _formKey;

  final userName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  final userNameLabel = 'username';
  final emailLabel = 'email';
  final adminType = AdminTypeEnum.Unknown.obs;
  final passwordLabel = 'password';
  final seePasswordObscure = true.obs;

  late Worker? _statusEverWorker;

  String currentState() =>
      'DialogController(status: ${status.value}, userName: ${userName.value}, email: ${email.value}, password: ${password.value}, confirmPassword: ${confirmPassword.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();

    super.onInit();
  }

  @override
  void onClose() {
    _statusEverWorker?.dispose();
    super.onClose();
  }

  void _monitorFeedItemsStatus() {
    _statusEverWorker = ever(
      status,
      (value) {
        if (value == DialogControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == DialogControllerStatus.loading) {
          myLogger.i(currentState);
        }
        if (value == DialogControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == DialogControllerStatus.submitted) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void updateUsername(String name) {
    userName.value = name;
  }

  void updateEmail(String emailPass) {
    email.value = emailPass;
  }

  void updatePassword(String pass) {
    password.value = pass;
  }

  void updateConfirmPassword(String conPass) {
    confirmPassword.value = conPass;
  }

  void updateSeePassword() {
    seePasswordObscure.value = !seePasswordObscure.value;
  }

  void setAdminValue(AdminTypeEnum admin) {
    adminType.value = admin;
  }

  Future<bool> submitAdminData() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    status.value = DialogControllerStatus.loading;

    if (!isValidationSuccessful) {
      Get.snackbar(
        'Warning!',
        "Please make sure no empty field.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Warning!',
        "Please make sure password is the same.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      status.value = DialogControllerStatus.error;
    } else {
      _signUpAdmin();
      status.value = DialogControllerStatus.submitted;
      Get.back(closeOverlays: true);
      Get.snackbar(
        'Success!',
        "Admin Created Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      getAllAminController.fetchAllAdmins();
      return true;
    }
    return false;
  }

  Future<void> _signUpAdmin() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value,
      );
      // User is signed up successfully.
      User? user = userCredential.user;
      final adminData = AdminModel(
        id: user!.uid,
        username: userName.value,
        email: email.value,
        adminType: adminType.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await AddAdminRepository.createNewAdmin(adminData);
      print('User ID: ${user.uid}');
    } catch (e) {
      // Error occurred while signing up.
      print('Error: $e');
    }
  }
}
