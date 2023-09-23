import 'package:admin/module/dashboard/dash_security_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/version_dropdown_widget.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/super_admin_header.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/tool_tip.dart';
import 'package:admin/responsive.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';

class SecurityOfficeHeader extends GetView<DashboardController> {
  final Function()? onClick;
  final bool isSuperAdmin;
  SecurityOfficeHeader({Key? key, this.onClick, this.isSuperAdmin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isSuperAdmin)
          Row(
            children: [
              Text(
                "Dashboard",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              Text(
                "> Security Office ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        if (!isSuperAdmin)
          Text(
            "Dashboard".toUpperCase(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 32),
          ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SecurityOfficeDropDown(),
            SizedBox(
              width: 10,
            ),
            GestureDetector(onTap: onClick, child: Text('Download')),
          ],
        )),
        if (isSuperAdmin) SuperAdminProfileCard(),
        if (!isSuperAdmin) SecurityOfficeProfileCard()
      ],
    );
  }
}

class SecurityOfficeProfileCard extends GetView<DashboardController> {
  const SecurityOfficeProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        // vertical: defaultPadding / 2,
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

class SecurityOfficeDropDown extends GetView<SecurityOfficeBarGraphController> {
  const SecurityOfficeDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: SecurityOfficeVersionDropdown(
        onChanged: (value) {
          if (value == null) {
            return;
          }
          controller.setVersion(value);
        },
      ),
    );
  }
}
