// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_library/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_library/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_library/widgets/header.dart';
import 'package:admin/module/dashboard/dash_library/widgets/respondents_widget.dart';

import '../../../../constants.dart';

class DashLibraryView extends StatefulWidget {
  final bool isSuperAdmin;
  const DashLibraryView({
    Key? key,
    required this.isSuperAdmin,
  }) : super(key: key);

  @override
  State<DashLibraryView> createState() => _DashLibraryViewState();
}

class _DashLibraryViewState extends State<DashLibraryView> {
  final libraryBarGraphController = LibraryBarGraphController.instance;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LibraryHeader(
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
            await libraryBarGraphController.generatePdf(controller);
          },
        ),
        Screenshot(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              LibraryBarChartWidget(),
              SizedBox(
                height: 40,
              ),
              LibraryRespondentsWidget()
            ],
          ),
        )
      ],
    );
  }
}
