import 'package:admin/module/dashboard_security_admin_office/controllers/security_admin_office_controller.dart';
import 'package:get/get.dart';

class DashboardSecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SecurityAdminOfficeController>(SecurityAdminOfficeController());
  }
}
