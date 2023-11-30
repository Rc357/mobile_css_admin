import 'package:admin/models/question_average_model.dart';
import 'package:flutter/material.dart';

class RatingEachNumberTwoPoints extends StatelessWidget {
  const RatingEachNumberTwoPoints({
    super.key,
    required this.questionTotalTwoPoints,
  });

  final List<QuestionTotalTwoPoints> questionTotalTwoPoints;

  @override
  Widget build(BuildContext context) {
    int totalYes = 0;
    int totalNo = 0;

    for (var i in questionTotalTwoPoints) {
      totalYes += i.totalYes;
      totalNo += i.totalNo;
    }

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
                            Container(
                              width: 70,
                              child: Text(
                                'Yes',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                'No',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              'Total Users',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ...questionTotalTwoPoints.asMap().entries.map((e) =>
                        buildQuestionRate(
                            e.key + 1,
                            e.value.question,
                            e.value.totalYes,
                            e.value.totalNo,
                            e.value.totalUser,
                            MediaQuery.of(context).size.width * .03)),
                    Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if ('$totalYes' != 'Infinity')
                                Container(
                                  width: 50,
                                  child: Text(
                                    '$totalYes',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              if ('$totalYes' == 'Infinity')
                                Container(
                                  width: 50,
                                  child: Text(
                                    '0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              SizedBox(
                                width: 8,
                              ),
                              if ('$totalNo' != 'Infinity')
                                Container(
                                  width: 70,
                                  child: Text(
                                    '$totalNo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              if ('$totalNo' == 'Infinity')
                                Container(
                                  width: 70,
                                  child: Text(
                                    '0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              SizedBox(
                                width: 8,
                              ),
                              if (totalYes > totalNo)
                                Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic),
                                ),
                              if (totalNo > totalYes)
                                Text(
                                  'No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildQuestionRate(int number, String question, int yes, int no,
          int userLength, double width) =>
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
                    if ('$yes' != 'Infinity')
                      Container(
                        width: 70,
                        child: Text(
                          '$yes',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    if ('$yes' == 'Infinity')
                      Container(
                        width: 70,
                        child: Text(
                          '0',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    if ('$no' != 'Infinity')
                      Container(
                        width: 70,
                        child: Text(
                          '$no',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    if ('$no' == 'Infinity')
                      Container(
                        width: 70,
                        child: Text(
                          '0',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    if ('$userLength' != 'Infinity')
                      Text(
                        '$userLength',
                        textAlign: TextAlign.right,
                      ),
                    if ('$userLength' == 'Infinity')
                      Text(
                        '0',
                        textAlign: TextAlign.right,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
