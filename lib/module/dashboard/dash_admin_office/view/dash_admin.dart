// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/respondents_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
    return Obx(
      () => Stack(alignment: Alignment.topCenter, children: [
        Column(
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
              onClickDate: () =>
                  adminOfficeBarGraphController.setViewCalendar(),
            ),
            adminOfficeBarGraphController.allQuestion.length == 0 &&
                    adminOfficeBarGraphController.kFlutterHashtags.length == 0
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .2,
                        ),
                        Text("No Data Found"),
                      ],
                    ),
                  )
                : Screenshot(
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
        ),
        if (adminOfficeBarGraphController.isViewCalendar.value)
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
                      adminOfficeBarGraphController.submitFilterByDate();
                      adminOfficeBarGraphController.setViewCalendar();
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
    adminOfficeBarGraphController.startDate.value = args.value.startDate;
    adminOfficeBarGraphController.endDate.value = args.value.endDate;
  }

  void _onCancelResetDate() {
    adminOfficeBarGraphController.startDate.value = DateTime.now();
    adminOfficeBarGraphController.endDate.value = DateTime.now();
    adminOfficeBarGraphController.setViewCalendar();
    adminOfficeBarGraphController.reloadData();
  }
}
