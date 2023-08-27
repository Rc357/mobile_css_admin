import 'package:admin/module/add_admin/widgets/text_field_widget.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:admin/module/add_survey/widgets/dropdown_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddQuestionDialog extends GetView<AddSurveyController> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Survey Question Number ${controller.questionNumber.value}',
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
                InputTextFieldWidget(
                  label: 'Add Question',
                  onChanged: (value) => controller.updateQuestion(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter question';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                AnswerTypeDropdown(
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    controller.updateTypeOfQuestion(value);
                  },
                  name: 'question${controller.questionNumber.value}',
                ),
                // selectionOption(
                //   context: context,
                //   initialValue: 'Excellent',
                //   onChanged: (value) => controller.updateExcellent(value!),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // selectionOption(
                //   context: context,
                //   initialValue: 'Very Satisfactory',
                //   onChanged: (value) =>
                //       controller.updateVerySatisfactory(value!),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // selectionOption(
                //   context: context,
                //   initialValue: 'Satisfactory',
                //   onChanged: (value) => controller.updateSatisfactory(value!),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // selectionOption(
                //   context: context,
                //   initialValue: 'Fair',
                //   onChanged: (value) => controller.updateFair(value!),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // selectionOption(
                //   context: context,
                //   initialValue: 'Poor',
                //   onChanged: (value) => controller.updatePoor(value!),
                // ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await controller.submitQuestion()) {
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
                  child: Text('Save',
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
                  child: Text('Close',
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
