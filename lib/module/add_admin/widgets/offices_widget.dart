import 'package:admin/module/add_admin/widgets/input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/get_admins_controller.dart';

class OfficesCardWidget extends GetView<GetAllAminController> {
  OfficesCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/add_admin/thumbs_up.svg',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Offices',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ))
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => CustomDialog(),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xfff0099cb),
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Add Admin Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                        )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                      onTap: () => controller.fetchAllAdmins(),
                      child: Icon(Icons.refresh_outlined))
                ],
              ),
            ],
          ),
        ));
  }
}
