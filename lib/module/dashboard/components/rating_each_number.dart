import 'package:admin/models/question_average_model.dart';
import 'package:flutter/material.dart';

class RatingEachNumber extends StatelessWidget {
  const RatingEachNumber({
    super.key,
    required this.questionAverageList,
  });

  final List<QuestionAverage> questionAverageList;

  @override
  Widget build(BuildContext context) {
    double overAllAverage = 0.0;
    double allAverage = 0.0;

    for (var i in questionAverageList) {
      allAverage += i.average;
    }
    overAllAverage = allAverage / questionAverageList.length;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rating of Each Questions',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Question',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * .02),
                          child: Row(
                            children: [
                              Text(
                                'Average',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...questionAverageList.asMap().entries.map((e) =>
                        buildQuestionRate(
                            e.key + 1,
                            e.value.question,
                            e.value.average,
                            MediaQuery.of(context).size.width * .03)),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Overall Average',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if ('${overAllAverage.toStringAsFixed(2)}' !=
                                'Infinity')
                              Text(
                                '${overAllAverage.toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            if ('${overAllAverage.toStringAsFixed(2)}' ==
                                'Infinity')
                              Text(
                                '0',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            SizedBox(
                              width: 8,
                            ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    5 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    4.2)
                              Text(
                                'Excellent',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    4.1 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    3.4)
                              Text(
                                'Very Good',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    3.4 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    2.6)
                              Text(
                                'Good',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    2.6 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    1.8)
                              Text(
                                'Fair',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    1.8 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    1.0)
                              Text(
                                'Poor',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    .99 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    .5)
                              Text(
                                'Excellent',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                            if (double.parse(
                                        overAllAverage.toStringAsFixed(2)) <=
                                    .49 &&
                                double.parse(
                                        overAllAverage.toStringAsFixed(2)) >=
                                    .0)
                              Text(
                                'Poor',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildQuestionRate(
          int number, String question, double average, double width) =>
      Column(
        children: [
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text('$number.) '),
                      Text(question),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: width),
                child: Row(
                  children: [
                    if ('${average.toStringAsFixed(2)}' != 'Infinity')
                      Text('${average.toStringAsFixed(2)}'),
                    if ('${average.toStringAsFixed(2)}' == 'Infinity')
                      Text('0'),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
