import 'package:admin/models/offices_args_model.dart';
import 'package:flutter/material.dart';

class OfficesCard extends StatelessWidget {
  const OfficesCard({super.key, required this.officesArgsData});

  final OfficesArgsData officesArgsData;

  @override
  Widget build(BuildContext context) {
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
                officesArgsData.officeName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Average Rating: '),
                        Text(officesArgsData.average.toStringAsFixed(2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Most User Type Visitor: '),
                        Text(officesArgsData.mostVisitedUser),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Questionnaire Type: '),
                        Text(officesArgsData.questionnaireType),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Questionnaire version available: '),
                        Text(officesArgsData.availableVersion),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 15, color: Colors.blue)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
