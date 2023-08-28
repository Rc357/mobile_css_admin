import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final adminData = Rxn<AdminModel>();

  @override
  void onInit() {
    getAdminData();
    super.onInit();
  }

  void getAdminData() async {
    final currentUser = firebaseAuth.currentUser!;
    adminData.value = await AddAdminRepository.getAdminViaId(currentUser.uid);
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
