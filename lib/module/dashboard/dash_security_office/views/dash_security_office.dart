// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_security_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/respondents_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
    return Obx(
      () => Stack(alignment: Alignment.topCenter, children: [
        Column(
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
              onClickDate: () =>
                  securityOfficeBarGraphController.setViewCalendar(),
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
        ),
        if (securityOfficeBarGraphController.isViewCalendar.value)
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                    backgroundColor: Colors.white,
                    showActionButtons: true,
                    cancelText: 'Cancel',
                    confirmText: 'Ok',
                    onCancel: _onCancelResetDate,
                    onSubmit: (p0) {
                      securityOfficeBarGraphController.submitFilterByDate();
                      securityOfficeBarGraphController.setViewCalendar();
                    },
                  ),
                ),
              ],
            ),
          )
      ]),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    securityOfficeBarGraphController.startDate.value = args.value.startDate;
    securityOfficeBarGraphController.endDate.value = args.value.endDate;
  }

  void _onCancelResetDate() {
    securityOfficeBarGraphController.startDate.value = DateTime.now();
    securityOfficeBarGraphController.endDate.value = DateTime.now();
    securityOfficeBarGraphController.setViewCalendar();
    securityOfficeBarGraphController.reloadData();
  }
}
