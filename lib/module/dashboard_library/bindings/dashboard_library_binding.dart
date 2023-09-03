import 'package:admin/module/dashboard_library/controllers/library_controller.dart';
import 'package:get/get.dart';

class DashboardLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LibraryController>(LibraryController());
  }
}
