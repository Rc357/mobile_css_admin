// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_cashier/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/header.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/respondents_widget.dart';

import '../../../../constants.dart';

class DashCashierView extends StatefulWidget {
  final bool isSuperAdmin;
  const DashCashierView({
    Key? key,
    required this.isSuperAdmin,
  }) : super(key: key);

  @override
  State<DashCashierView> createState() => _DashCashierViewState();
}

class _DashCashierViewState extends State<DashCashierView> {
  final cashierBarGraphController = CashierBarGraphController.instance;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CashierHeader(
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
            await cashierBarGraphController.generatePdf(controller);
          },
        ),
        Screenshot(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              CashierBarChartWidget(),
              SizedBox(
                height: 40,
              ),
              CashierRespondentsWidget()
            ],
          ),
        )
      ],
    );
  }
}
