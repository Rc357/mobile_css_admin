import 'package:admin/module/add_survey/controller/edit_survey_controller.dart';
import 'package:admin/module/add_survey/widgets/delete_survey_dialog.dart';
import 'package:admin/module/add_survey/widgets/edit_survey_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin/models/question_model.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';

class QuestionCardWidget extends GetView<AddSurveyController> {
  const QuestionCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.allQuestion.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('No Question Yet'),
            ))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.allQuestion.length,
              itemBuilder: (context, index) {
                final admin = controller.allQuestion[index];
                return cardWidget(admin, context);
              },
            ),
    );
  }

  Widget cardWidget(QuestionModel question, BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Row(
            children: [
              Text(question.questionNumber.toString() + '.) ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              Text(question.question,
                  style: TextStyle(
                    color: Color(0xff0262AC),
                    fontSize: 18,
                  )),
            ],
          ),
          subtitle: Text('Answer Type: ' + question.type.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
          trailing: TooltipWithActions(question),
        ),
      );
}

class TooltipWithActions extends StatelessWidget {
  TooltipWithActions(this.question);
  final QuestionModel question;

  final editSurveyController = EditSurveyController.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = button.localToGlobal(Offset.zero);

        final RelativeRect position = RelativeRect.fromLTRB(
          buttonPosition.dx,
          buttonPosition.dy + button.size.height,
          buttonPosition.dx + button.size.width,
          buttonPosition.dy +
              button.size.height +
              40, // Adjust this for the height of the popup
        );

        // Show a popup menu button as a tooltip
        showMenu(
          context: context,
          position: position,
          items: <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Question'),
                onTap: () async {
                  Get.back();
                  editSurveyController.updateOldQuestion(question);
                  await showDialog(
                    context: context,
                    builder: (context) => EditQuestionDialog(question),
                  );
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Delete Question',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context); // Close the popup menu
                  await showDialog(
                    context: context,
                    builder: (context) => DeleteQuestionDialog(question),
                  );
                },
              ),
            ),
          ],
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        // color: Colors.blue,
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
