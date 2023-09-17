import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/dashboard/dash_admin_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_cashier/widgets/header.dart';
import 'package:admin/module/dashboard/dash_library/widgets/header.dart';
import 'package:admin/module/dashboard/dash_registrar/widgets/header.dart';
import 'package:admin/module/dashboard/dash_security_office/widgets/header.dart';
import 'package:admin/module/dashboard/dash_super_admin/widgets/tool_tip.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../constants.dart';

class Header2 extends GetView<DashboardController> {
  Header2({
    Key? key,
  }) : super(key: key);

  final dashSuperAdminGraphController = MainScreenController.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            dashSuperAdminGraphController.setAdminView(AdminTypeEnum.Unknown);
          },
          child: Text(
            "Dashboard",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.blue),
          ),
        ),
        Text(
          "> ${dashSuperAdminGraphController.adminView.value.description}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (dashSuperAdminGraphController.adminView.value ==
            AdminTypeEnum.Admin)
          Expanded(child: AdminOfficeDropDown()),
        if (dashSuperAdminGraphController.adminView.value ==
            AdminTypeEnum.CashierAdmin)
          Expanded(child: CashierDropDown()),
        if (dashSuperAdminGraphController.adminView.value ==
            AdminTypeEnum.LibraryAdmin)
          Expanded(child: LibraryDropDown()),
        if (dashSuperAdminGraphController.adminView.value ==
            AdminTypeEnum.RegistrarAdmin)
          Expanded(child: RegistrarDropDown()),
        if (dashSuperAdminGraphController.adminView.value ==
            AdminTypeEnum.SecurityAdmin)
          Expanded(child: SecurityOfficeDropDown()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends GetView<DashboardController> {
  const ProfileCard({
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
