import 'package:admin/responsive.dart';
// import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/module/dashboard/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget_mobile.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../components/header.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
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
            BarChartWidget(),
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
