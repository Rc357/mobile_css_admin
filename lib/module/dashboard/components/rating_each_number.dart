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
                        Row(
                          children: [
                            Text(
                              'Average',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ...questionAverageList.asMap().entries.map((e) =>
                        buildQuestionRate(
                            e.key + 1, e.value.question, e.value.average)),
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
                            Text(
                              '${overAllAverage.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.w600),
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

  Widget buildQuestionRate(int number, String question, double average) =>
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
              Row(
                children: [
                  Text('${average.toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        ],
      );
}
