import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/header.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/dash_library/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_library/widgets/header.dart';
import 'package:admin/module/dashboard/dash_library/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/header.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/header.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/header2.dart';
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
                      ? Column(
                          children: [
                            LibraryHeader(),
                            SizedBox(height: defaultPadding),
                            LibraryBarChartWidget(),
                            SizedBox(
                              height: 40,
                            ),
                            LibraryRespondentsWidget()
                          ],
                        )
                      : controller.adminData.value!.adminType ==
                              AdminTypeEnum.Admin
                          ? Column(
                              children: [
                                AdminOfficeHeader(),
                                SizedBox(height: defaultPadding),
                                AdminOfficeBarChartWidget(),
                                SizedBox(
                                  height: 40,
                                ),
                                AdminOfficeRespondentsWidget()
                              ],
                            )
                          : controller.adminData.value!.adminType ==
                                  AdminTypeEnum.CashierAdmin
                              ? Column(
                                  children: [
                                    CashierHeader(),
                                    SizedBox(height: defaultPadding),
                                    CashierBarChartWidget(),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    CashierRespondentsWidget()
                                  ],
                                )
                              : controller.adminData.value!.adminType ==
                                      AdminTypeEnum.RegistrarAdmin
                                  ? Column(
                                      children: [
                                        RegistrarHeader(),
                                        SizedBox(height: defaultPadding),
                                        RegistrarBarChartWidget(),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        RegistrarRespondentsWidget()
                                      ],
                                    )
                                  : controller.adminData.value!.adminType ==
                                          AdminTypeEnum.SecurityAdmin
                                      ? Column(
                                          children: [
                                            SecurityOfficeHeader(),
                                            SizedBox(height: defaultPadding),
                                            SecurityOfficeBarChartWidget(),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            SecurityOfficeRespondentsWidget()
                                          ],
                                        )
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
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25.0),
                                                        child:
                                                            OfficesListCard(),
                                                      ),
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.Admin)
                                                  Column(
                                                    children: [
                                                      Header2(),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      AdminOfficeBarChartWidget(),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      AdminOfficeRespondentsWidget()
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.CashierAdmin)
                                                  Column(
                                                    children: [
                                                      Header2(),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      CashierBarChartWidget(),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      CashierRespondentsWidget()
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.LibraryAdmin)
                                                  Column(
                                                    children: [
                                                      Header2(),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      LibraryBarChartWidget(),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      LibraryRespondentsWidget()
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum
                                                        .RegistrarAdmin)
                                                  Column(
                                                    children: [
                                                      Header2(),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      RegistrarBarChartWidget(),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      RegistrarRespondentsWidget()
                                                    ],
                                                  ),
                                                if (dashSuperAdminGraphController
                                                        .adminView.value ==
                                                    AdminTypeEnum.SecurityAdmin)
                                                  Column(
                                                    children: [
                                                      Header2(),
                                                      SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      SecurityOfficeBarChartWidget(),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      SecurityOfficeRespondentsWidget()
                                                    ],
                                                  ),
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
