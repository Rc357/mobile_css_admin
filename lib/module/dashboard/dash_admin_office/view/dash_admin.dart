// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/respondents_widget.dart';

import '../../../../constants.dart';

class DashAdminView extends StatefulWidget {
  final bool isSuperAdmin;
  const DashAdminView({
    Key? key,
    required this.isSuperAdmin,
  }) : super(key: key);

  @override
  State<DashAdminView> createState() => _DashAdminViewState();
}

class _DashAdminViewState extends State<DashAdminView> {
  final adminOfficeBarGraphController = AdminOfficeBarGraphController.instance;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminOfficeHeader(
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
            await adminOfficeBarGraphController.generatePdf(controller);
          },
        ),
        Screenshot(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              AdminOfficeBarChartWidget(),
              SizedBox(
                height: 40,
              ),
              AdminOfficeRespondentsWidget()
            ],
          ),
        )
      ],
    );
  }
}
