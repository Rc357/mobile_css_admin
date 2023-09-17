import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:admin/module/add_survey/widgets/add_survey_dialog.dart';
import 'package:admin/module/add_survey/widgets/add_thank_you_dialog.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class AddSurveyMenu extends GetView<AddSurveyController> {
  AddSurveyMenu({
    Key? key,
  }) : super(key: key);

  final menuAppController = DashboardController.instance;
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
              children: [
                if (!Responsive.isMobile(context))
                  Row(
                    children: [
                      Text(
                        controller.args.adminName + " ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        "Questionnaire",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ],
                  ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AddQuestionDialog(),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/dashboard/add.svg"),
                          Text(
                            'Add New Survey Question',
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => ThankYouMessageDialog(),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/dashboard/add.svg"),
                          Text(
                            'Add Thank You Message',
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
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
