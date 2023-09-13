import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOfficePieChartSample3 extends StatefulWidget {
  const AdminOfficePieChartSample3();

  @override
  State<StatefulWidget> createState() => AdminOfficePieChartSample3State();
}

class AdminOfficePieChartSample3State extends State {
  int touchedIndex = 0;

  final adminOfficeBarGraphController = AdminOfficeBarGraphController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => adminOfficeBarGraphController.isLoading
          ? Center(
              child: LoadingIndicator(color: Colors.blue),
            )
          : AspectRatio(
              aspectRatio: 1.3,
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: adminOfficeBarGraphController.totalAlumni.value != 0
                ? double.parse(
                    adminOfficeBarGraphController.totalAlumni.value.toString())
                : 0,
            title:
                '${((adminOfficeBarGraphController.totalAlumni.value / adminOfficeBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: adminOfficeBarGraphController.totalParent.value != 0
                ? double.parse(
                    adminOfficeBarGraphController.totalParent.value.toString())
                : 0,
            title:
                '${((adminOfficeBarGraphController.totalParent.value / adminOfficeBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: adminOfficeBarGraphController.totalStudent.value != 0
                ? double.parse(
                    adminOfficeBarGraphController.totalStudent.value.toString())
                : 0,
            title:
                '${((adminOfficeBarGraphController.totalStudent.value / adminOfficeBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.blue,
            value: adminOfficeBarGraphController.totalGuest.value != 0
                ? double.parse(
                    adminOfficeBarGraphController.totalGuest.value.toString())
                : 0,
            title:
                '${((adminOfficeBarGraphController.totalGuest.value / adminOfficeBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}
