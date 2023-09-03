import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:admin/module/add_survey_version/widgets/delete_survey_version_dialog.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class QuestionnaireVersionCardWidget
    extends GetView<AddSurveyVersionController> {
  const QuestionnaireVersionCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.allQuestionnaireVersion.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('No Questionnaire Version Yet'),
            ))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.allQuestionnaireVersion.length,
              itemBuilder: (context, index) {
                final version = controller.allQuestionnaireVersion[index];
                return cardWidget(version, context);
              },
            ),
    );
  }

  Widget cardWidget(QuestionnaireVersionModel version, BuildContext context) {
    final isHover = false.obs;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: InkWell(
        onTap: () {
          final argsUpdate = ArgumentsToPass(
              adminName: controller.args.adminName,
              questionAdminName: controller.args.questionAdminName,
              regardsAdminName: controller.args.regardsAdminName,
              questionnaireOffice: controller.args.questionnaireOffice,
              questionnaireVersion: version.questionnaireVersion.toString(),
              versionID: version.id);
          Get.toNamed(
            AppPages.ADD_SURVEY,
            arguments: argsUpdate,
          );
        },
        onHover: (val) {
          isHover.value = val;
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color:
                    isHover.value ? Colors.blue.withOpacity(0.1) : Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              title: Center(
                child: Text(
                    'Questionnaire Version ' +
                        version.questionnaireVersion.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ),
              subtitle: Column(
                children: [
                  Text(
                      'Updated Date: ${DateFormat('yMMMd').format(version.updatedAt)} at ${DateFormat.jms().format(version.updatedAt)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                  Text(
                      'Created Date: ${DateFormat('yMMMd').format(version.createdAt)} at ${DateFormat.jms().format(version.createdAt)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                ],
              ),
              trailing: TooltipWithActions(version),
            ),
          ),
        ),
      ),
    );
  }
}

class TooltipWithActions extends StatelessWidget {
  TooltipWithActions(this.question);
  final QuestionnaireVersionModel question;

  // final editSurveyVersionController = EditSurveyVersionController.instance;
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
            // PopupMenuItem(
            //   child: ListTile(
            //     leading: Icon(Icons.edit),
            //     title: Text('Edit Version'),
            //     onTap: () async {
            //       Get.back();
            //       editSurveyVersionController.updateOldQuestion(question);
            //       await showDialog(
            //         context: context,
            //         builder: (context) => EditQuestionVersionDialog(question),
            //       );
            //     },
            //   ),
            // ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Delete Version',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context); // Close the popup menu
                  await showDialog(
                    context: context,
                    builder: (context) => DeleteQuestionVersionDialog(question),
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
