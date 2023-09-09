import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/module/dashboard_version/controller/office_version_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeVersionCardWidget extends GetView<OfficeVersionController> {
  const OfficeVersionCardWidget({Key? key}) : super(key: key);

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
          controller.toOfficeScreen(version);
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
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Click to view the list of respondent in this version.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
