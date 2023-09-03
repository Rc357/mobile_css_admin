import 'package:admin/module/dashboard_admin_office/views/admin_office_screen.dart';
import 'package:admin/module/dashboard_cashier/views/cashier_screen.dart';
import 'package:admin/module/dashboard_registrar/views/registrar_screen.dart';
import 'package:admin/module/dashboard_security_admin_office/views/security_admin_office_screen.dart';
import 'package:admin/module/dashboard_version/views/version_selection.dart';
import 'package:admin/responsive.dart';
import 'package:admin/module/add_admin/views/add_admin.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/views/dashboard_screen.dart';
import 'package:admin/module/dashboard_library/views/library_screen.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/side_menu.dart';

class MainScreen extends StatelessWidget {
  final menuAppController = DashboardController.instance;
  final mainScreenController = MainScreenController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuAppController.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Obx(
              () => Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: mainScreenController.currentScreenIndex.value == 0
                      ? DashboardScreen()
                      : mainScreenController.currentScreenIndex.value == 1
                          ? AddAdminScreen()
                          : VersionSelection()),
            ),
          ],
        ),
      ),
    );
  }
}
