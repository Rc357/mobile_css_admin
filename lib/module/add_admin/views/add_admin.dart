import 'package:admin/module/add_admin/widgets/body_card.dart';
import 'package:admin/module/add_admin/widgets/header.dart';
import 'package:admin/module/add_admin/widgets/offices_widget.dart';
import 'package:admin/widgets/loading_overlay_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../controller/get_admins_controller.dart';

class AddAdminScreen extends GetView<GetAllAminController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => controller.isLoading ? false : true,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(children: [
          SafeArea(
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  AddAdminHeader(),
                  SizedBox(height: defaultPadding),
                  OfficesCardWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  BodyCardWidget(),
                ],
              ),
            ),
          ),
          _buildLoadingOverlay()
        ]),
      ),
    );
  }

  Obx _buildLoadingOverlay() =>
      Obx(() => LoadingOverlay(isLoading: controller.isLoading));
}
