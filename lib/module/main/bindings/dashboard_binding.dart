import 'package:admin/module/add_admin/controller/create_admin_dialog_controller.dart';
import 'package:admin/module/add_admin/controller/delete_admin_controller.dart';
import 'package:admin/module/add_admin/controller/get_admins_controller.dart';
import 'package:admin/module/dashboard/controllers/MenuAppController.dart';
import 'package:admin/module/dashboard/controllers/bar_graph_controller.dart';
import 'package:admin/module/dashboard/controllers/logout_controller.dart';
import 'package:admin/module/dashboard_version/controller/office_version_controller.dart';
import 'package:admin/module/main/controller/main_screen_controller.dart';
import 'package:get/instance_manager.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OfficeVersionController>(OfficeVersionController());
    Get.put<MainScreenController>(MainScreenController());
    Get.put<DashboardController>(DashboardController());
    Get.put<BarGraphController>(BarGraphController());
    Get.put<GetAllAminController>(GetAllAminController());
    Get.put<CreateAdminDialogController>(CreateAdminDialogController());
    Get.put<DeleteAdminController>(DeleteAdminController());
    Get.put<LogOutController>(LogOutController());
  }
}
