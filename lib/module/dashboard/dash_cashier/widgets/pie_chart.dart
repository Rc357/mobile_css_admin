import 'package:admin/module/dashboard/dash_cashier/controller/bar_graph_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashierPieChartSample3 extends StatefulWidget {
  const CashierPieChartSample3();

  @override
  State<StatefulWidget> createState() => CashierPieChartSample3State();
}

class CashierPieChartSample3State extends State {
  int touchedIndex = 0;

  final cashierBarGraphController = CashierBarGraphController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cashierBarGraphController.isLoading
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
            value: cashierBarGraphController.totalAlumni.value != 0
                ? double.parse(
                    cashierBarGraphController.totalAlumni.value.toString())
                : 0,
            title:
                '${((cashierBarGraphController.totalAlumni.value / cashierBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: cashierBarGraphController.totalParent.value != 0
                ? double.parse(
                    cashierBarGraphController.totalParent.value.toString())
                : 0,
            title:
                '${((cashierBarGraphController.totalParent.value / cashierBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: cashierBarGraphController.totalStudent.value != 0
                ? double.parse(
                    cashierBarGraphController.totalStudent.value.toString())
                : 0,
            title:
                '${((cashierBarGraphController.totalStudent.value / cashierBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: cashierBarGraphController.totalGuest.value != 0
                ? double.parse(
                    cashierBarGraphController.totalGuest.value.toString())
                : 0,
            title:
                '${((cashierBarGraphController.totalGuest.value / cashierBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
