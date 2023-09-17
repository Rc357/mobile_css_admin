import 'package:admin/models/admin_model.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutTooltipWithActions extends GetView<LogOutController> {
  LogoutTooltipWithActions(this.adminData);
  final AdminModel adminData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = button.localToGlobal(Offset.zero);

        final RelativeRect position = RelativeRect.fromLTRB(
          buttonPosition.dx,
          buttonPosition.dy + button.size.height,
          buttonPosition.dx + button.size.width,
          buttonPosition.dy +
              button.size.height +
              40, // Adjust this for the height of the popup
        );

        // Show a popup menu button as a tooltip
        showMenu(
          context: context,
          position: position,
          items: <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.logout_rounded),
                title: Text('Logout'),
                onTap: () async {
                  Get.back(closeOverlays: true);
                  controller.logOutAdmin();
                },
              ),
            ),
          ],
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
