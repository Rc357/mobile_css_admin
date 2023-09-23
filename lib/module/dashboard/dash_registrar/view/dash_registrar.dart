// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_registrar/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/header.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/respondents_widget.dart';

import '../../../../constants.dart';

class DashRegistrarView extends StatefulWidget {
  final bool isSuperAdmin;
  const DashRegistrarView({
    Key? key,
    required this.isSuperAdmin,
  }) : super(key: key);

  @override
  State<DashRegistrarView> createState() => _DashRegistrarViewState();
}

class _DashRegistrarViewState extends State<DashRegistrarView> {
  final registrarBarGraphController = RegistrarBarGraphController.instance;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegistrarHeader(
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
            await registrarBarGraphController.generatePdf(controller);
          },
        ),
        Screenshot(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              RegistrarBarChartWidget(),
              SizedBox(
                height: 40,
              ),
              RegistrarRespondentsWidget()
            ],
          ),
        )
      ],
    );
  }
}
