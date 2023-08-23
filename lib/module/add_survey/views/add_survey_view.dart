import 'package:admin/module/add_survey/widgets/add_survey_header.dart';
import 'package:admin/module/add_survey/widgets/add_survey_menu.dart';
import 'package:admin/module/add_survey/widgets/message_card.dart';
import 'package:admin/module/add_survey/widgets/question_card.dart';
import 'package:flutter/material.dart';

class AddSurveyView extends StatelessWidget {
  const AddSurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddSurveyHeader(),
              AddSurveyMenu(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text('List of Available Question ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    QuestionCardWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text('Thank You Message',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    MessageCardWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
