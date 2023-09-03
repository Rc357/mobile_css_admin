import 'package:admin/module/add_survey_version/controller/add_survey_version_controller.dart';
import 'package:admin/module/add_survey_version/widgets/add_survey_version_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class AddSurveyVersionMenu extends GetView<AddSurveyVersionController> {
  AddSurveyVersionMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      controller.args.adminName + " ",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      "Questionnaire Version",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AddQuestionVersionDialog(),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/dashboard/add.svg"),
                          Text(
                            'Add New Questionnaire Version',
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
