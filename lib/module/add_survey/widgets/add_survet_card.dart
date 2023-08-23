import 'package:flutter/material.dart';

class AddSurveyCard extends StatelessWidget {
  const AddSurveyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(
                7.0, // Move to right 7.0 horizontally
                8.0, // Move to bottom 8.0 Vertically
              ))
        ],
      ),
      child: Column(children: [Text('Add Survey Question')]),
    );
  }
}
