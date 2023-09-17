import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/constants.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final dashboardController = DashboardController.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: sideColor,
      child: Obx(
        () => ListView(
          children: dashboardController.drawerChildren,
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        height: 16,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
