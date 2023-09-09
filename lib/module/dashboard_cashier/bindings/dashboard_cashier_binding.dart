import 'package:admin/module/dashboard_cashier/controllers/cashier_controller.dart';
import 'package:get/get.dart';

class DashboardCashierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CashierController>(CashierController());
  }
}
