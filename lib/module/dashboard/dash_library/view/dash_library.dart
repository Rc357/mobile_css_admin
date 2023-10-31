// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'package:admin/module/dashboard/dash_library/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_library/widgets/app_bar_widget.dart';
import 'package:admin/module/dashboard/dash_library/widgets/header.dart';
import 'package:admin/module/dashboard/dash_library/widgets/respondents_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
    return Obx(
      () => Stack(alignment: Alignment.topCenter, children: [
        Column(
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
              onClickDate: () => libraryBarGraphController.setViewCalendar(),
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
        ),
        if (libraryBarGraphController.isViewCalendar.value)
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
                      libraryBarGraphController.submitFilterByDate();
                      libraryBarGraphController.setViewCalendar();
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
    libraryBarGraphController.startDate.value = args.value.startDate;
    libraryBarGraphController.endDate.value = args.value.endDate;
  }

  void _onCancelResetDate() {
    libraryBarGraphController.startDate.value = DateTime.now();
    libraryBarGraphController.endDate.value = DateTime.now();
    libraryBarGraphController.setViewCalendar();
    libraryBarGraphController.reloadData();
  }
}
