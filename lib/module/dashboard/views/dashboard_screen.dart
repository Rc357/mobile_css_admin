import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
// import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/module/dashboard/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../components/header.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Obx(
              () => controller.adminData.value != null
                  ? controller.adminData.value!.adminType !=
                          AdminTypeEnum.SuperAdmin
                      ? BarChartWidget()
                      : SizedBox()
                  : SizedBox(),
            ),
            SizedBox(
              height: 40,
            ),
            if (!Responsive.isMobile(context)) RespondentsWidget(),
            if (Responsive.isMobile(context)) RespondentsWidgetMobile(),
          ],
        ),
      ),
    );
  }
}
