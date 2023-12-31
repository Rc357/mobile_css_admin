import 'package:admin/enums/admin_enum.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/argument_to_pass.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';
import 'package:admin/module/add_admin/widgets/delete_survey_dialog.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BodyCardWidget extends GetView<GetAllAminController> {
  const BodyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.allAdmins.isEmpty
          ? Center(child: Text('No admin yet'))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.allAdmins.length,
              itemBuilder: (context, index) {
                final admin = controller.allAdmins[index];
                return cardWidget(admin, context);
              },
            ),
    );
  }

  Widget cardWidget(AdminModel admin, BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Text(admin.adminType.description,
              style: TextStyle(
                color: Color(0xff0262AC),
                fontSize: 18,
              )),
          subtitle: Row(
            children: [
              Text(
                  'Updated on ${DateFormat('yMMMd').format(admin.updatedAt)}, by ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              Text(admin.adminType.name,
                  style: TextStyle(
                    color: Color(0xff0262AC),
                    fontSize: 18,
                  )),
            ],
          ),
          trailing: TooltipWithActions(admin),
        ),
      );
}

class TooltipWithActions extends StatelessWidget {
  TooltipWithActions(this.adminData);
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
                leading: Icon(Icons.edit),
                title: Text('Add/Edit Survey'),
                onTap: () {
                  Get.back();
                  final args = Rxn<ArgumentsToPass>();
                  if (adminData.adminType == AdminTypeEnum.LibraryAdmin) {
                    args.value = ArgumentsToPass(
                        adminName: 'Library',
                        questionAdminName: 'questionsLibrary',
                        regardsAdminName: 'regardsLibrary',
                        questionnaireOffice: 'questionnaireVersionLibrary',
                        questionnaireVersion: '',
                        versionID: '');
                  } else if (adminData.adminType == AdminTypeEnum.Admin) {
                    args.value = ArgumentsToPass(
                        adminName: "Admin's Office",
                        questionAdminName: 'questionsAdminsOffice',
                        regardsAdminName: 'regardsAdminsOffice',
                        questionnaireOffice: 'questionnaireVersionAdminsOffice',
                        questionnaireVersion: '',
                        versionID: '');
                  } else if (adminData.adminType ==
                      AdminTypeEnum.SecurityAdmin) {
                    args.value = ArgumentsToPass(
                        adminName: 'Security Office',
                        questionAdminName: 'questionsSecurityOffice',
                        regardsAdminName: 'regardsSecurityOffice',
                        questionnaireOffice:
                            'questionnaireVersionSecurityOffice',
                        questionnaireVersion: '',
                        versionID: '');
                  } else if (adminData.adminType ==
                      AdminTypeEnum.RegistrarAdmin) {
                    args.value = ArgumentsToPass(
                        adminName: 'Registrar',
                        questionAdminName: 'questionsRegistrar',
                        regardsAdminName: 'regardsRegistrar',
                        questionnaireOffice: 'questionnaireVersionRegistrar',
                        questionnaireVersion: '',
                        versionID: '');
                  } else if (adminData.adminType ==
                      AdminTypeEnum.CashierAdmin) {
                    args.value = ArgumentsToPass(
                        adminName: 'Cashier',
                        questionAdminName: 'questionsCashier',
                        regardsAdminName: 'regardsCashier',
                        questionnaireOffice: 'questionnaireVersionCashier',
                        questionnaireVersion: '',
                        versionID: '');
                  }

                  Get.toNamed(
                    AppPages.ADD_SURVEY_VERSION,
                    arguments: args.value,
                  );
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Delete Admin',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await showDialog(
                    context: context,
                    builder: (context) => DeleteAdminDialog(adminData),
                  );

                  // Close the popup menu
                  // Perform the delete action
                },
              ),
            ),
          ],
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        // color: Colors.blue,
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
