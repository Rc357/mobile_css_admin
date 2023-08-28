import 'package:admin/models/question_model.dart';
import 'package:admin/module/add_survey/controller/delete_survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class DeleteQuestionDialog extends GetView<DeleteSurveyController> {
  DeleteQuestionDialog(this.questionData);
  final QuestionModel questionData;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete this question?',
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
                  'The question: ${questionData.question} with ${questionData.type.description} of answer will permanently deleted.',
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
              controller.deleteQuestion(questionData.id);
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

  Widget selectionOption(
          {required String initialValue,
          required void Function(String?) onChanged,
          required BuildContext context}) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                maxLength: 1,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Points',
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: Colors.blue), //<-- SEE HERE
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.blue), //<-- SEE HERE
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: Colors.red), //<-- SEE HERE
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
                  ),
                ),
                onChanged: onChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: initialValue,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: Colors.blue), //<-- SEE HERE
                  ),
                ),
                onChanged: null,
                validator: null,
              ),
            ),
          ],
        ),
      );
}
