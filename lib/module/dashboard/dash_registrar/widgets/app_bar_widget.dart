import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/module/dashboard/components/rating_each_number.dart';
import 'package:admin/module/dashboard/dash_registrar/controller/bar_graph_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrarBarChartWidget extends GetView<RegistrarBarGraphController> {
  @override
  Widget build(BuildContext context) {
    final double barWith = 15;
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
              height: 350,
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
                                    interval: controller.intervalNumber.value,
                                    getTitlesWidget: (value, meta) =>
                                        Text(value.toString()),
                                  ),
                                ),
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
                                                .allQuestion[i].yes
                                                .toString()),
                                            color: Colors.blue,
                                            width: barWith,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(controller
                                                .allQuestion[i].no
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
        if (controller.typeOfQuestionnaire.value == 'Five Points Case')
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLegend('Excellent', Colors.blue),
                buildLegend('Very Satisfactory', Colors.green),
                buildLegend('Satisfactory', Colors.yellow),
                buildLegend('Fair', Colors.orange),
                buildLegend('Poor', Colors.red),
              ],
            ),
          ),
        if (controller.typeOfQuestionnaire.value == 'Two Points Case')
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLegend('Yes', Colors.blue),
                buildLegend('No', Colors.red),
              ],
            ),
          ),
        Obx(() =>
            Text("Total Number of Respondents: ${controller.users.length}",
                style: TextStyle(
                  color: Color(0xff0262AC),
                  fontSize: 18,
                ))),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.isLoading
              ? Center(
                  child: LoadingIndicator(color: Colors.blue),
                )
              : controller.eachNumAverageList.length != 0
                  ? RatingEachNumber(
                      questionAverageList: controller.eachNumAverageList,
                    )
                  : SizedBox(),
        )
      ],
    );
  }

  Widget buildLegend(String label, Color color) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Row(
          children: [
            SizedBox(
              width: 10,
              child: CircleAvatar(
                backgroundColor: color,
              ),
            ),
            Text(
              ' $label',
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      );
}
