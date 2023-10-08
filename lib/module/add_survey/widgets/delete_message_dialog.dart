import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:admin/models/thank_you_message_model.dart';
import 'package:admin/module/add_survey/controller/delete_message_controller.dart';

class DeleteMessageDialog extends GetView<DeleteMessageController> {
  DeleteMessageDialog(this.messageData);
  final ThankYouMessageModel messageData;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete this message?',
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
                  '"${messageData.message}" will permanently deleted.\nAll the data related to this message will be lost.',
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
              controller.deleteMessage(messageData.messageId);
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
