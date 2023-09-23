// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_security_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/respondents_widget.dart';

import '../../../../constants.dart';

class DashSecurityOfficeView extends StatefulWidget {
  final bool isSuperAdmin;
  const DashSecurityOfficeView({
    Key? key,
    required this.isSuperAdmin,
  }) : super(key: key);

  @override
  State<DashSecurityOfficeView> createState() => _DashSecurityOfficeViewState();
}

class _DashSecurityOfficeViewState extends State<DashSecurityOfficeView> {
  final securityOfficeBarGraphController =
      SecurityOfficeBarGraphController.instance;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SecurityOfficeHeader(
          isSuperAdmin: widget.isSuperAdmin,
          onClick: () async {
            Get.snackbar(
              'Processing',
              "Please wait while capturing...",
              colorText: Colors.white,
              backgroundColor: Colors.lightBlue,
              icon: const Icon(Icons.add_alert),
            );
            await Future.delayed(const Duration(seconds: 2));
            await securityOfficeBarGraphController.generatePdf(controller);
          },
        ),
        Screenshot(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              SecurityOfficeBarChartWidget(),
              SizedBox(
                height: 40,
              ),
              SecurityOfficeRespondentsWidget()
            ],
          ),
        )
      ],
    );
  }
}
