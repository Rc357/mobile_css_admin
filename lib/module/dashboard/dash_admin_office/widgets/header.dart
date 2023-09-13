import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/version_dropdown_widget.dart';
import 'package:admin/module/dashboard/widgets/tool_tip.dart';
import 'package:admin/responsive.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';

class AdminOfficeHeader extends GetView<DashboardController> {
  AdminOfficeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Expanded(child: AdminOfficeDropDown()),
        AdminOfficeProfileCard()
      ],
    );
  }
}

class AdminOfficeProfileCard extends GetView<DashboardController> {
  const AdminOfficeProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Obx(
        () => controller.adminData.value != null
            ? Row(
                children: [
                  if (!Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: Text('${controller.adminData.value!.username}'),
                    ),
                  LogoutTooltipWithActions(controller.adminData.value!),
                ],
              )
            : SizedBox(),
      ),
    );
  }
}

class AdminOfficeDropDown extends GetView<AdminOfficeBarGraphController> {
  const AdminOfficeDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 200,
          child: AdminOfficeVersionDropdown(
            onChanged: (value) {
              if (value == null) {
                return;
              }
              controller.setVersion(value);
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              controller.getRemarksList();
            },
            child: Text('Download')),
      ],
    );
  }
}
