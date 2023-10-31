import 'package:admin/module/dashboard_security_admin_office/controllers/security_admin_office_controller.dart';
import 'package:admin/module/dashboard_security_admin_office/widgets/user_card.dart';
import 'package:admin/widgets/respondent_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class SecurityAdminOfficeScreen extends StatelessWidget {
  final controller = SecurityAdminOfficeController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(closeOverlays: true),
                    child: Text(
                      "Version List",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                  Text(
                    "Respondents",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Text(
                "Security Office Respondents".toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              RespondentsHeader(),
              SecurityAdminOfficeUserCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
