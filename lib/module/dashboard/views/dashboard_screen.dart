import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/dashboard/dash_admin_office/view/dash_admin.dart';
import 'package:admin/module/dashboard/dash_cashier/view/dash_cashier.dart';
import 'package:admin/module/dashboard/dash_library/view/dash_library.dart';
import 'package:admin/module/dashboard/dash_registrar/view/dash_registrar.dart';
import 'package:admin/module/dashboard/dash_security_office/views/dash_security_office.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/header.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/offices.dart';

import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class DashboardScreen extends GetView<DashboardController> {
  final dashSuperAdminGraphController = MainScreenController.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Obx(
              () => controller.adminData.value != null
                  ? controller.adminData.value!.adminType ==
                          AdminTypeEnum.LibraryAdmin
                      ? DashLibraryView(isSuperAdmin: false)
                      : controller.adminData.value!.adminType ==
                              AdminTypeEnum.Admin
                          ? DashAdminView(isSuperAdmin: false)
                          : controller.adminData.value!.adminType ==
                                  AdminTypeEnum.CashierAdmin
                              ? DashCashierView(isSuperAdmin: false)
                              : controller.adminData.value!.adminType ==
                                      AdminTypeEnum.RegistrarAdmin
                                  ? DashRegistrarView(isSuperAdmin: false)
                                  : controller.adminData.value!.adminType ==
                                          AdminTypeEnum.SecurityAdmin
                                      ? DashSecurityOfficeView(
                                          isSuperAdmin: false)
                                      : controller.adminData.value!.adminType ==
                                              AdminTypeEnum.SuperAdmin
                                          ? Column(
                                              children: [
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.Unknown)
                                                  Column(
                                                    children: [
                                                      Header(),
                                                      SizedBox(height: 10),
                                                      Divider(),
                                                      SizedBox(height: 10),
                                                      OfficesListCard(),
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.Admin)
                                                  DashAdminView(
                                                    isSuperAdmin: true,
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.CashierAdmin)
                                                  DashCashierView(
                                                      isSuperAdmin: true),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.LibraryAdmin)
                                                  DashLibraryView(
                                                      isSuperAdmin: true),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum
                                                        .RegistrarAdmin)
                                                  DashRegistrarView(
                                                      isSuperAdmin: true),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.SecurityAdmin)
                                                  DashSecurityOfficeView(
                                                      isSuperAdmin: true),
                                              ],
                                            )
                                          : SizedBox()
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
