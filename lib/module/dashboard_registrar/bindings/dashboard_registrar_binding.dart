import 'package:admin/module/dashboard_registrar/controllers/registrar_controller.dart';
import 'package:get/get.dart';

class DashboardRegistrarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegistrarController>(RegistrarController());
  }
}
