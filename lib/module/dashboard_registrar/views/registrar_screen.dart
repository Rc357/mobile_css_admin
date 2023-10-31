import 'package:admin/module/dashboard_registrar/controllers/registrar_controller.dart';
import 'package:admin/module/dashboard_registrar/widgets/user_card.dart';
import 'package:admin/widgets/respondent_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class RegistrarScreen extends StatelessWidget {
  final controller = RegistrarController.instance;
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
                "Registrar Respondents".toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              RespondentsHeader(),
              RegistrarUserCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
