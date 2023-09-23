import 'package:admin/module/add_admin/controller/create_admin_dialog_controller.dart';
import 'package:admin/module/add_admin/controller/delete_admin_controller.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/dash_super_admin/controllers/logout_controller.dart';
import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_cashier/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_library/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_registrar/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard/dash_security_office/controller/bar_graph_controller.dart';
import 'package:admin/module/dashboard_version/controller/office_version_controller.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:get/instance_manager.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OfficeVersionController>(OfficeVersionController());
    Get.put<MainScreenController>(MainScreenController());
    Get.put<DashboardController>(DashboardController());
    Get.put<AdminOfficeBarGraphController>(AdminOfficeBarGraphController());
    Get.put<CashierBarGraphController>(CashierBarGraphController());
    Get.put<LibraryBarGraphController>(LibraryBarGraphController());
    Get.put<RegistrarBarGraphController>(RegistrarBarGraphController());
    Get.put<SecurityOfficeBarGraphController>(
        SecurityOfficeBarGraphController());
    Get.put<GetAllAminController>(GetAllAminController());
    Get.put<CreateAdminDialogController>(CreateAdminDialogController());
    Get.put<DeleteAdminController>(DeleteAdminController());
    Get.put<LogOutController>(LogOutController());
  }
}
