import 'package:admin/module/dashboard_version/widgets/office_version_card.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class VersionSelection extends GetView<MainScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(
              "${controller.nameDisplay.value} Version Respondents"
                  .toUpperCase(),
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 15,
            ),
            OfficeVersionCardWidget(),
          ],
        ),
      ),
    );
  }
}
