import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bar_graph_controller.dart';

class BarChartWidget extends GetView<BarGraphController> {
  @override
  Widget build(BuildContext context) {
    final double barWith = 10;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            RotatedBox(
              quarterTurns: -1,
              child: RichText(
                text: TextSpan(
                  text: 'Respondent Highest Number',
                  style: DefaultTextStyle.of(context).style,
                ),
              ),
            ),
            Container(
              height: 300,
              width: .7 * MediaQuery.of(context).size.width,
              child: Obx(
                () => controller.isLoading
                    ? Center(
                        child: LoadingIndicator(color: Colors.blue),
                      )
                    : controller.allQuestion.isEmpty
                        ? SizedBox(
                            child: Center(child: Text('No Questions Fetched')),
                          )
                        : BarChart(
                            BarChartData(
                              gridData: FlGridData(
                                  drawVerticalLine: false,
                                  drawHorizontalLine: true),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                              'Question ${value.toInt()}');
                                        })),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                )),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              barGroups: [
                                for (int i = 0;
                                    i < controller.allQuestion.length;
                                    i++)
                                  controller.allQuestion[i].type ==
                                          QuestionTypeEnum.fivePointsCase
                                      ? BarChartGroupData(x: i + 1, barRods: [
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].excellent
                                                .toString()),
                                            color: Colors.blue,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].verySatisfactory
                                                .toString()),
                                            color: Colors.green,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].satisfactory
                                                .toString()),
                                            color: Colors.yellow,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].fair
                                                .toString()),
                                            color: Colors.orange,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].poor
                                                .toString()),
                                            color: Colors.red,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ])
                                      : BarChartGroupData(x: i + 1, barRods: [
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].agree
                                                .toString()),
                                            color: Colors.blue,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].disagree
                                                .toString()),
                                            color: Colors.red,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ]),
                              ],
                              borderData: FlBorderData(show: true),
                            ),
                          ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Obx(
          () => controller.totalRespondents.isNotEmpty
              ? Text(
                  "Total Number of Respondents: ${controller.totalRespondents[0]}",
                  style: TextStyle(
                    color: Color(0xff0262AC),
                    fontSize: 18,
                  ))
              : Text("Total Number of Respondents: 0}",
                  style: TextStyle(
                    color: Color(0xff0262AC),
                    fontSize: 18,
                  )),
        ),
      ],
    );
  }
}
