import 'package:admin/responsive.dart';
import 'package:admin/module/dashboard/components/header.dart';
// import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/module/dashboard/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget.dart';
import 'package:admin/module/dashboard/widgets/respondents_widget_mobile.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

class SettingsScreen extends StatelessWidget {
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
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       flex: 5,
            //       child: Column(
            //         children: [
            //           MyFiles(),
            //           SizedBox(height: defaultPadding),
            //           RecentFiles(),
            //           if (Responsive.isMobile(context))
            //             SizedBox(height: defaultPadding),
            //           if (Responsive.isMobile(context)) StorageDetails(),
            //         ],
            //       ),
            //     ),
            //     if (!Responsive.isMobile(context))
            //       SizedBox(width: defaultPadding),
            //     // On Mobile means if the screen is less than 850 we don't want to show it
            //     if (!Responsive.isMobile(context))
            //       Expanded(
            //         flex: 2,
            //         child: StorageDetails(),
            //       ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
