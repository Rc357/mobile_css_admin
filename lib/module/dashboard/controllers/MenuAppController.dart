import 'package:admin/enums/admin_enum.dart';
import 'package:admin/instances/firebase_instances.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/module/main/components/side_menu.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:admin/repositories/add_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final mainScreenController = MainScreenController.instance;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final adminData = Rxn<AdminModel>();

  final drawerChildren = <Widget>[].obs;

  @override
  void onInit() {
    getAdminData();
    super.onInit();
  }

  void getAdminData() async {
    final currentUser = firebaseAuth.currentUser!;
    adminData.value = await AddAdminRepository.getAdminViaId(currentUser.uid);

    setDashboardData();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setDashboardData() {
    if (adminData.value != null) {
      if (adminData.value!.adminType == AdminTypeEnum.LibraryAdmin) {
        drawerChildren.value = [
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
            title: "Library",
            svgSrc: "assets/icons/nav_menu/library.svg",
            press: () => mainScreenController.updateScreenIndex(2),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      } else if (adminData.value!.adminType == AdminTypeEnum.Admin) {
        drawerChildren.value = [
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
            title: "Admin Office",
            svgSrc: "assets/icons/nav_menu/admin.svg",
            press: () => mainScreenController.updateScreenIndex(6),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      } else if (adminData.value!.adminType == AdminTypeEnum.SecurityAdmin) {
        drawerChildren.value = [
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
            title: "Security Admin Office",
            svgSrc: "assets/icons/nav_menu/security_admin.svg",
            press: () => mainScreenController.updateScreenIndex(5),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      } else if (adminData.value!.adminType == AdminTypeEnum.RegistrarAdmin) {
        drawerChildren.value = [
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
            title: "Registrar",
            svgSrc: "assets/icons/nav_menu/registrar.svg",
            press: () => mainScreenController.updateScreenIndex(4),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      } else if (adminData.value!.adminType == AdminTypeEnum.CashierAdmin) {
        drawerChildren.value = [
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
            title: "Cashier",
            svgSrc: "assets/icons/nav_menu/cashier.svg",
            press: () => mainScreenController.updateScreenIndex(3),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      } else if (adminData.value!.adminType == AdminTypeEnum.SuperAdmin) {
        drawerChildren.value = [
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
            title: "Report Management",
            svgSrc: "assets/icons/nav_menu/management.svg",
            press: () => mainScreenController.updateScreenIndex(1),
          ),
          ExpansionTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/nav_menu/menu_.svg",
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  height: 10,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Offices',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DrawerListTile(
                  title: "Library",
                  svgSrc: "assets/icons/nav_menu/library.svg",
                  press: () => mainScreenController.updateScreenIndex(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DrawerListTile(
                  title: "Cashier",
                  svgSrc: "assets/icons/nav_menu/cashier.svg",
                  press: () => mainScreenController.updateScreenIndex(3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DrawerListTile(
                  title: "Registrar",
                  svgSrc: "assets/icons/nav_menu/registrar.svg",
                  press: () => mainScreenController.updateScreenIndex(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DrawerListTile(
                  title: "Security Admin Office",
                  svgSrc: "assets/icons/nav_menu/security_admin.svg",
                  press: () => mainScreenController.updateScreenIndex(5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DrawerListTile(
                  title: "Admin Office",
                  svgSrc: "assets/icons/nav_menu/admin.svg",
                  press: () => mainScreenController.updateScreenIndex(6),
                ),
              ),
            ],
          ),
          // DrawerListTile(
          //   title: "Library",
          //   svgSrc: "assets/icons/nav_menu/library.svg",
          //   press: () => mainScreenController.updateScreenIndex(2),
          // ),
          // DrawerListTile(
          //   title: "Cashier",
          //   svgSrc: "assets/icons/nav_menu/cashier.svg",
          //   press: () => mainScreenController.updateScreenIndex(3),
          // ),
          // DrawerListTile(
          //   title: "Registrar",
          //   svgSrc: "assets/icons/nav_menu/registrar.svg",
          //   press: () => mainScreenController.updateScreenIndex(4),
          // ),
          // DrawerListTile(
          //   title: "Security Admin Office",
          //   svgSrc: "assets/icons/nav_menu/security_admin.svg",
          //   press: () => mainScreenController.updateScreenIndex(5),
          // ),
          // DrawerListTile(
          //   title: "Admin Office",
          //   svgSrc: "assets/icons/nav_menu/admin.svg",
          //   press: () => mainScreenController.updateScreenIndex(6),
          // ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => mainScreenController.updateScreenIndex(7),
          ),
        ];
      }
    }
  }
}
