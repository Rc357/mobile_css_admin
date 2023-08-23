import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: .7 * MediaQuery.of(context).size.width,
      child: BarChart(
        BarChartData(
          gridData:
              FlGridData(drawVerticalLine: false, drawHorizontalLine: true),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                toY: 100,
                color: Colors.green,
                width: 30,
                borderRadius: BorderRadius.circular(4),
              ),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: 6,
                color: Colors.green,
                width: 30,
                borderRadius: BorderRadius.circular(4),
              ),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                toY: 10,
                color: Colors.green,
                width: 30,
                borderRadius: BorderRadius.circular(4),
              ),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                toY: 10,
                color: Colors.green,
                width: 30,
                borderRadius: BorderRadius.circular(4),
              ),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                toY: 10,
                color: Colors.green,
                width: 30,
                borderRadius: BorderRadius.circular(4),
              ),
            ]),
            // Add more BarChartGroupData for additional bars
          ],
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
