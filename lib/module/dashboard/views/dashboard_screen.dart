import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
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
import 'package:admin/module/dashboard/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class DashboardScreen extends GetView<DashboardController> {
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
                                      : Header()
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
