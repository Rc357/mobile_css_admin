import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/module/add_survey_version/controller/delete_survey_version_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class DeleteQuestionVersionDialog
    extends GetView<DeleteSurveyVersionController> {
  DeleteQuestionVersionDialog(this.questionData, this.argumentsToPass);
  final QuestionnaireVersionModel questionData;
  final ArgumentsToPass argumentsToPass;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete this version?',
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Theme(
            data: ThemeData(
              disabledColor: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "The questionnaire version ${questionData.questionnaireVersion} will permanently deleted.\nAll the data related to this version will be lost.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              controller.deleteQuestion(questionData.id,
                  questionData.questionnaireVersion, argumentsToPass);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * .05,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xfff0099cb),
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text('Delete',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                )),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
                width: MediaQuery.of(context).size.width * .05,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text('Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
