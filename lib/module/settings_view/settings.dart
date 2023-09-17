import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class SettingsScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            // Obx(
            //   () => controller.adminData.value != null
            //       ? controller.adminData.value!.adminType !=
            //               AdminTypeEnum.SuperAdmin
            //           ? BarChartWidget()
            //           : SizedBox()
            //       : SizedBox(),
            // ),

            SizedBox(
              height: 40,
            ),
            // if (!Responsive.isMobile(context)) RespondentsWidget(),
            // if (Responsive.isMobile(context)) RespondentsWidgetMobile(),
          ],
        ),
      ),
    );
  }
}
