import 'package:admin/module/dashboard_admin_office/controllers/admin_office_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:admin/models/question_model.dart';

class AdminOfficeUserCardWidget extends GetView<AdminOfficeController> {
  const AdminOfficeUserCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.users.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('No Answer Yet'),
            ))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                return buildUserCard(
                    context,
                    controller.extractInitials(user.name),
                    user.name,
                    DateFormat.yMd().add_jm().format(user.createdAt).toString(),
                    user.userType,
                    user.answered);
              },
            ),
    );
  }

  Widget buildUserCard(BuildContext context, String initial, String name,
          String visitedTime, String identity, bool isAnswered) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * .017,
                child: Text(initial,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ))),
            Expanded(
                flex: 2,
                child: Text(visitedTime,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ))),
            Expanded(
                flex: 2,
                child: Text(identity,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ))),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .03,
                      decoration: BoxDecoration(
                          color: Color(0xFF0099CB),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Answer Survey',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                )),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .01,
                    ),
                    isAnswered
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.pending_actions_outlined,
                            color: Colors.blue,
                          ),
                  ],
                )),
          ]),
        ),
      );
}

class TooltipWithActions extends StatelessWidget {
  TooltipWithActions(this.adminData);
  final QuestionModel adminData;
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
                title: Text('Edit Question'),
                onTap: () {
                  Get.back(closeOverlays: true);
                  // Get.toNamed(
                  //   AppPages.ADD_SURVEY,
                  //   arguments: adminData,
                  // );
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Delete Question',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the popup menu
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
