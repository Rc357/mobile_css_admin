import 'package:admin/module/dashboard/dash_registrar/controller/bar_graph_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrarPieChartSample3 extends StatefulWidget {
  const RegistrarPieChartSample3();

  @override
  State<StatefulWidget> createState() => RegistrarPieChartSample3State();
}

class RegistrarPieChartSample3State extends State {
  int touchedIndex = 0;

  final registrarBarGraphController = RegistrarBarGraphController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => registrarBarGraphController.isLoading
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
            value: registrarBarGraphController.totalAlumni.value != 0
                ? double.parse(
                    registrarBarGraphController.totalAlumni.value.toString())
                : 0,
            title:
                '${((registrarBarGraphController.totalAlumni.value / registrarBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: registrarBarGraphController.totalParent.value != 0
                ? double.parse(
                    registrarBarGraphController.totalParent.value.toString())
                : 0,
            title:
                '${((registrarBarGraphController.totalParent.value / registrarBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: registrarBarGraphController.totalStudent.value != 0
                ? double.parse(
                    registrarBarGraphController.totalStudent.value.toString())
                : 0,
            title:
                '${((registrarBarGraphController.totalStudent.value / registrarBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
            value: registrarBarGraphController.totalGuest.value != 0
                ? double.parse(
                    registrarBarGraphController.totalGuest.value.toString())
                : 0,
            title:
                '${((registrarBarGraphController.totalGuest.value / registrarBarGraphController.users.length) * 100).toStringAsFixed(0)}%',
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
