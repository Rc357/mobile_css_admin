import 'package:admin/splash/controller/auth_controller.dart';
import 'package:admin/splash/controller/check_internet_controller.dart';
import 'package:admin/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(CheckInternetController());
    Get.put(AuthController(), permanent: true);
  }
}
