import 'package:admin/module/add_admin/widgets/text_field_widget.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ThankYouMessageDialog extends GetView<AddSurveyController> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Message',
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
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTextFieldWidget(
                    label: 'Thank you message',
                    onChanged: (value) =>
                        controller.updateThankYouMessage(value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter message';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if (controller.imageName.isNotEmpty)
                    Text('File Name: ${controller.imageName.value}'),
                  TextButton(
                    onPressed: () async {
                      controller.takePhoto();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * .05,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color(0xfff0099cb),
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text('Add Image',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await controller.submitThankYouMessage()) {
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
}
