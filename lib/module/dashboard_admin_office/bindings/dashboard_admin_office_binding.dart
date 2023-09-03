import 'package:admin/module/dashboard_admin_office/controllers/admin_office_controller.dart';
import 'package:get/get.dart';

class DashboardAdminOfficeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminOfficeController>(AdminOfficeController());
  }
}
