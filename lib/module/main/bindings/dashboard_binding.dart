import 'package:admin/module/add_admin/controller/create_admin_dialog_controller.dart';
import 'package:admin/module/add_admin/controller/delete_admin_controller.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/controllers/bar_graph_controller.dart';
import 'package:admin/module/dashboard/controllers/logout_controller.dart';
import 'package:admin/module/dashboard_admin_office/controllers/admin_office_controller.dart';
import 'package:admin/module/dashboard_cashier/controllers/library_controller.dart';
import 'package:admin/module/dashboard_library/controllers/library_controller.dart';
import 'package:admin/module/dashboard_registrar/controllers/registrar_controller.dart';
import 'package:admin/module/dashboard_security_admin_office/controllers/security_admin_office_controller.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:get/instance_manager.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<MainScreenController>(MainScreenController());
    Get.put<BarGraphController>(BarGraphController());
    Get.put<GetAllAminController>(GetAllAminController());
    Get.put<LibraryController>(LibraryController());
    Get.put<CashierController>(CashierController());
    Get.put<RegistrarController>(RegistrarController());
    Get.put<AdminOfficeController>(AdminOfficeController());
    Get.put<SecurityAdminOfficeController>(SecurityAdminOfficeController());
    Get.put<CreateAdminDialogController>(CreateAdminDialogController());
    Get.put<DeleteAdminController>(DeleteAdminController());
    Get.put<LogOutController>(LogOutController());
  }
}
