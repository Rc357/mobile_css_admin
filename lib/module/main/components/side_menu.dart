import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/constants.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final mainScreenController = MainScreenController.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: sideColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: SvgPicture.asset("assets/icons/nav_menu/logo.svg",
                semanticsLabel: 'Acme Logo'),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => mainScreenController.updateScreenIndex(0),
          ),
          DrawerListTile(
            title: "Add Admin",
            svgSrc: "assets/icons/nav_menu/add_admin.svg",
            press: () => mainScreenController.updateScreenIndex(1),
          ),
          DrawerListTile(
            title: "Library",
            svgSrc: "assets/icons/nav_menu/library.svg",
            press: () => mainScreenController.updateScreenIndex(2),
          ),
          DrawerListTile(
            title: "Cashier",
            svgSrc: "assets/icons/nav_menu/cashier.svg",
            press: () => mainScreenController.updateScreenIndex(3),
          ),
          DrawerListTile(
            title: "Registrar",
            svgSrc: "assets/icons/nav_menu/registrar.svg",
            press: () => mainScreenController.updateScreenIndex(4),
          ),
          DrawerListTile(
            title: "Security Admin Office",
            svgSrc: "assets/icons/nav_menu/security_admin.svg",
            press: () => mainScreenController.updateScreenIndex(5),
          ),
          DrawerListTile(
            title: "Admin Office",
            svgSrc: "assets/icons/nav_menu/admin.svg",
            press: () => mainScreenController.updateScreenIndex(6),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ],
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
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
