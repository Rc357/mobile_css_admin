import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddQuestionVersionDialog extends GetView<AddSurveyVersionController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add New Survey Questionnaire Version ${controller.allQuestionnaireVersion.length + 1}?',
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
      content: Theme(
        data: ThemeData(
          disabledColor: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () async {
                if (await controller.submitQuestionVersion()) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * .05,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xfff0099cb),
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text('YES',
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
                    child: Text('CANCEL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                  )),
            ),
          ],
        ),
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
