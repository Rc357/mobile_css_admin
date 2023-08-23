import 'package:admin/models/thank_you_message_model.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';

class MessageCardWidget extends GetView<AddSurveyController> {
  const MessageCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.allMessages.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('No Message Yet'),
            ))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.allMessages.length,
              itemBuilder: (context, index) {
                final admin = controller.allMessages[index];
                return cardWidget(admin, context);
              },
            ),
    );
  }

  Widget cardWidget(ThankYouMessageModel message, BuildContext context) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Text(message.message,
              style: TextStyle(
                color: Color(0xff0262AC),
                fontSize: 18,
              )),
          subtitle: Row(
            children: [
              Text(
                  'Updated on ${DateFormat('yMMMd').format(message.updatedAt)} ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  )),
              Text(
                  'Created Date ${DateFormat('yMMMd').format(message.createdAt)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  )),
              SizedBox(
                width: 25,
              ),
              if (message.image.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    controller.getMessagesViaId(message.messageId);
                  },
                  child: Text('Preview Image',
                      style: TextStyle(
                        color: Color(0xff0262AC),
                        fontSize: 15,
                      )),
                ),
            ],
          ),
          trailing: TooltipWithActions(message),
        ),
      );
}

class TooltipWithActions extends StatelessWidget {
  TooltipWithActions(this.adminData);
  final ThankYouMessageModel adminData;
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
                title: Text('Edit Message'),
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
                  'Delete Message',
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
