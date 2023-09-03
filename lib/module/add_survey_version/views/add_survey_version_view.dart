import 'package:admin/module/add_survey_version/widgets/add_survey_menu_version.dart';
import 'package:admin/module/add_survey_version/widgets/add_survey_version_header.dart';
import 'package:admin/module/add_survey_version/widgets/questionnaire_version_card.dart';
import 'package:flutter/material.dart';

class AddSurveyVersionView extends StatelessWidget {
  const AddSurveyVersionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddSurveyVersionHeader(),
              AddSurveyVersionMenu(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text('List of Available Questionnaire Version ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    QuestionnaireVersionCardWidget(),
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
