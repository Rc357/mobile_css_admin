// import 'package:admin/responsive.dart';

import 'package:admin/module/dashboard_cashier/controllers/cashier_controller.dart';
import 'package:admin/module/dashboard_cashier/widgets/user_card.dart';
import 'package:admin/widgets/respondent_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class CashierScreen extends StatelessWidget {
  final controller = CashierController.instance;
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
                "Cashier Respondents".toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              RespondentsHeader(),
              CashierUserCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
