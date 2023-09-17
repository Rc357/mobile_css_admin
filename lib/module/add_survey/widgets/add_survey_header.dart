import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class AddSurveyHeader extends StatelessWidget {
  AddSurveyHeader({
    Key? key,
  }) : super(key: key);

  final menuAppController = DashboardController.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: menuAppController.controlMenu,
            ),
          if (!Responsive.isMobile(context))
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(closeOverlays: true),
                  child: Text(
                    "Create Version ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
                Text(
                  "Create Survey ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Row(
            children: [
              SvgPicture.asset("assets/icons/dashboard/notification.svg"),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset("assets/icons/dashboard/profile.svg"),
            ],
          ),
        ],
      ),
    );
  }
}
